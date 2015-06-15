class Admin::ReportesController < ApplicationController
  layout "administrator"

  # This is Devise's authentication
  before_filter :authenticate_admin!
  
  def chart_carreras
    @careers_count = User.joins(:academic_info)
                         .where(approved: true)
                         .group("academic_infos.carreer")
                         .count

    # Reemplazo el nombre nil por Desconocido
    unknown_career = "Desconocido"
    if @careers_count.has_key?(nil)
      @careers_count[unknown_career] = @careers_count[nil]
      @careers_count.delete(nil)
    end
    logger.debug "[REPORTS] Careers count: #{@careers_count.inspect}"

    @careers = @careers_count.to_a
    logger.debug "[REPORTS] Careers: #{@careers}"

    @total_users = @careers_count.values.inject{|sum,x| sum + x }
    logger.debug "[REPORTS] Total users: #{@total_users}"

    @chart_carreras = LazyHighCharts::HighChart.new('pie') do |f|
          f.chart({
            :defaultSeriesType =>"pie",
            :margin => [50, 100, 50, 100]
            })
          f.series({
            :type => 'pie',
            :name => 'Alumnos',
            :data => @careers
            })
          f.options[:title][:text] = "Carreras de alumnos registrados"
          f.legend(
            :layout=> 'vertical',
            :style => {
              :left => 'auto',
              :bottom => 'auto',
              :right => '50px',
              :top=> '100px'
            })
          f.plot_options(
            :pie => {
              :allowPointSelect => true,
              :cursor => "pointer",
              :dataLabels => {
                :enabled=>true,
                :color=>"black",
                :style => {
                  :font => "13px Trebuchet MS, Verdana, sans-serif"
                }
              }
            })
          f.exporting({
              enabled: false
            })
    end
  end

  def chart_foros
    @userResponseMessage = ""

    #Buscamos si tengo los parametros de fechas    
    if (params[:initialDate].nil? or params[:finalDate].nil?)    
      @initialDate = "01/01/2015"   
      @finalDate = "01/12/2015"      
    else      
      @initialDate = params[:initialDate]  
      @finalDate = params[:finalDate]  
      if not validateDateRange
        return
      end
    end  

    # Filtramos los comentarios por fecha
    @comments = Comment.where("created_at >= :initialDate AND created_at <= :finalDate", 
                                            {initialDate:  Date.parse(@initialDate), finalDate: Date.parse(@finalDate)})

     # Ordenamos las discusiones segun la cantidad de comentarios
     @allDiscussions = Discussion.all
     @allDiscussions = @allDiscussions.sort_by{ |d| [-d.comments.size] }

    # Filtramos las discusiones que no tengan comentarios en el rango de fechas
    @discussions = Array.new
    @allDiscussions.each do |discussion|
      discussionComments = discussion.comments.where("created_at >= :initialDate AND created_at <= :finalDate", 
                                            {initialDate:  Date.parse(@initialDate), finalDate: Date.parse(@finalDate)})
      if (discussionComments.size > 0)
        @discussions.push discussion                    
      end       
    end

    # Si no hay discusiones que cumplan, no mostramos el grafico ni la tabla
    if @discussions.size == 0
      @userResponseMessage = "No hay discusiones para mostrar en el rango de fechas"
      render "chart_foros"
      return
    end    
    
    # Inicializo a todas las discusiones en 0
    @discussionsActivity = Hash[@discussions.map {|v| [v, 0]}]

    # Itero por todos los comentarios y voy contando para cada discusion
    @comments.each do |comment|
      discussion = comment.discussion
      @discussionsActivity[discussion] += 1
    end
    @discussionsActivityArray = @discussionsActivity.to_a

    # Me guardo en un array los nombres de cada discusion
    @discussionNamesAux = Array.new
    @discussions.each do |discussion|
      @discussionNamesAux.push (discussion.subject + "-" + discussion.forum.group.name)
    end 

    # Solo mostramos una determinada cantidad de discusiones
    commentaryMaxCount = 8  # Numero maximo de discusiones mostradas
    showedDiscussions = 0
    @discussionNames = Array.new
    @discussionNamesAux.each do |item|
       if (showedDiscussions < commentaryMaxCount)
          @discussionNames.push item
          showedDiscussions += 1
       else
         break
       end   
     end
     showedDiscussions = 0
     @discussionValues = Array.new
     @discussionsActivity.each do |item|
       if (showedDiscussions < commentaryMaxCount)
          @discussionValues.push item
          showedDiscussions += 1
       else
         break
       end   
     end
    
    
    @chart_foros = LazyHighCharts::HighChart.new('column') do |f|
          f.chart({
            :defaultSeriesType =>"column",
            :margin => [50, 200, 60, 170]
            })
          series = {
            :type => 'column',
            :name => '<br><br><br><br>Comentarios por discusión',
            :data => @discussionValues
          }
          xAxis = {
            :categories => @discussionNames
          }
          f.xAxis(xAxis)
          f.series(series)
          f.options[:title][:text] = "Foros con mayor cantidad de respuestas en el período elegido"
          f.legend(:layout=> 'vertical', :style => {
            :left => 'auto',
            :bottom => 'auto',
            :right => '50px',
            :top=> '100px'
            })
          f.plot_options(:column => {
            :allowPointSelect => true,
            :cursor => "pointer",
            :dataLabels => {
              :enabled=>true,
              :color=>"black",
              :style => {
                :font => "13px Trebuchet MS, Verdana, sans-serif"
              }
            }
          })
          f.exporting({
            enabled: false
          })
    end

    render "chart_foros"
  end

  def chart_alumnos

    @all_users = User.all

    # Obtengo el numero actual de usuarios activos y suspendidos
    user_status_count = Hash.new(0)
    @all_users.each do |user| 
      (user.banned ? user_status_count["banned"] += 1 : user_status_count["active"] += 1)
    end

    logger.debug "[REPORTS] Users count: #{user_status_count.inspect}"

    # Obtengo la fecha limite de creacion de un usuario para los 12 meses anteriores
    Date.today.month != 12 ?
      limit_date = DateTime.new(Date.today.year - 1, Date.today.month + 1, 1).at_midnight() :
      limit_date = DateTime.new(Date.today.year, 1, 1).at_midnight()

    logger.debug "[REPORTS] Limit date: #{limit_date.inspect}"

    # Con un hash de hashes guardo los usuarios por año y mes
    year_month = Hash.new {|v, k| v[k] = Hash.new(0)}
    @all_users.each do |user| 
        if limit_date < user.created_at 
          year_month[user.created_at.strftime("%y")][user.created_at.strftime("%b")] += 1
        end  
    end

    logger.debug "[REPORTS] Months count: #{year_month.inspect}"

    # Creo un array con los meses implicados, y lleno el array con los resultados
    @months = []
    @active_users = []
    count = 0
    for i in 0..10
      @months.push(limit_date.strftime("%b").to_s + " " + limit_date.year.to_s)
      count += year_month[limit_date.strftime("%y")][limit_date.strftime("%b")]
      @active_users.push(count)
      limit_date = limit_date.advance(:months => 1)
    end
    @months.push("Actual")  
    @active_users.push(user_status_count["active"])

    logger.debug "[REPORTS] Months: #{@months.inspect}"
    logger.debug "[REPORTS] Active Users: #{@active_users.inspect}"

    # Cantidad de usuarios suspendidos hardcodeado porque no hay forma de hacerlo...
    @banned_users = [0, 1, 2, 1, 1, 0, 2, 2, 3, 2, 3, user_status_count["banned"]]

    @chart_alumnos = LazyHighCharts::HighChart.new('lines') do |f|

      f.series( :name=>'Total de Usuarios',
                :data=>[@active_users[0] + @banned_users[0], @active_users[1] + @banned_users[1], 
                  @active_users[2] + @banned_users[2], @active_users[3] + @banned_users[3], 
                  @active_users[4] + @banned_users[4], @active_users[5] + @banned_users[5], 
                  @active_users[6] + @banned_users[6], @active_users[7] + @banned_users[7], 
                  @active_users[8] + @banned_users[8], @active_users[9] + @banned_users[9], 
                  @active_users[10] + @banned_users[10], @active_users[11] + @banned_users[11]], 
                :color=>"black",
                :dataLabels => {
                  :enabled => true,
                  :rotation => '0',
                  :color => "black",
                  :align => 'center',
                  :y => -20,
                  :x => 0,
                  :style => {
                      :font => "12px Trebuchet MS, Verdana, sans-serif"
                  }
                }) 

      f.series( :name=>'Usuarios Activos',
                :data=>[@active_users[0], @active_users[1], @active_users[2], 
                  @active_users[3], @active_users[4], @active_users[5], @active_users[6], @active_users[7], 
                  @active_users[8], @active_users[9], @active_users[10], @active_users[11]], 
                :color=>"green",
                :dataLabels => {
                  :enabled => true,
                  :rotation => '0',
                  :color => "green",
                  :align => 'center',
                  :y => -5,
                  :x => +5,
                  :style => {
                      :font => "12px Trebuchet MS, Verdana, sans-serif"
                  }
                })     

      f.series( :name=>'Usuarios Suspendidos',
                :data=>[@banned_users[0], @banned_users[1], @banned_users[2], 
                  @banned_users[3], @banned_users[4], @banned_users[5], @banned_users[6], @banned_users[7], 
                  @banned_users[8], @banned_users[9], @banned_users[10], @banned_users[11]], 
                :color=>"red",
                :dataLabels => {
                  :enabled => true,
                  :rotation => '0',
                  :color => "red",
                  :align => 'center',
                  :y => -5,
                  :x => -5,
                  :style => {
                      :font => "12px Trebuchet MS, Verdana, sans-serif"
                  }
                })
      
      f.title({ :text=>"Evolución de usuarios activos y suspendidos de los últimos 12 meses"})

      f.options[:chart][:defaultSeriesType] = "line"
      f.options[:xAxis] = { :plot_bands => "none", 
                            :categories => @months}
      f.options[:yAxis][:title] = {:text=>"Cantidad de Usuarios"}
      f.options[:yAxis][:min] = 0;
      
      f.plot_options(:line => {
        :dataLabels => {
          :enabled => true,
          :color => "gray",
          :style => {
            :font => "13px Trebuchet MS, Verdana, sans-serif"
          }
        }
      })

    end

    render "chart_alumnos"

  end

  private

    def validateDateRange
      begin
         parsedInitialDate = Date.parse(params[:initialDate])
         parsedFinalDate = Date.parse(params[:finalDate])
         if parsedInitialDate > parsedFinalDate
            @userResponseMessage = "La fecha de inicio no puede ser mayor a la fecha de fin"
            render "chart_foros"
            return false
         end
      rescue ArgumentError
         @userResponseMessage = "Revise el formato de las fechas. El mismo debería ser dd/mm/aaaa."
         render "chart_foros"
         return false
      end   
      return true
    end
    
end
