class Admin::ReportesController < ApplicationController
  layout "administrator"

  # This is Devise's authentication
  before_filter :authenticate_admin!
  
  def chart_carreras
    @approved_users = User.all

    # Consigo todas las carreras ( select distinct )
    @careers_name = AcademicInfo.uniq.pluck(:carreer)

    # Reemplazo el nombre nil por Desconocido
    unknown_career = "Desconocido"
    if @careers_name.include?(nil)
      nil_index = @careers_name.index(nil)
      @careers_name[nil_index] = unknown_career
    end
    logger.debug "[REPORTS] Careers name: #{@carreers_name}"

    @total_numer_of_approved_users = @approved_users.size

    # Inicializo a todas las carreras en 0
    @careers = Hash[@careers_name.map {|v| [v, 0]}]

    #itero por todos los usuarios registrados y voy contando las carreras
    @approved_users.each do |user|
      career_name = user.academic_info.carreer || unknown_career
      @careers[career_name] += 1/Float( @careers_name.size)
    end

    @careers = @careers.to_a

    @chart_carreras = LazyHighCharts::HighChart.new('pie') do |f|
          f.chart({
            :defaultSeriesType =>"pie",
            :margin => [50, 200, 60, 170]
            })
          series = {
            :type => 'pie',
            :name => 'carreras',
            :data => @careers
          }
          f.series(series)
          f.options[:title][:text] = "Carreras de alumnos registrados"
          f.legend(:layout=> 'vertical', :style => {
            :left => 'auto',
            :bottom => 'auto',
            :right => '50px',
            :top=> '100px'
            })
          f.plot_options(:pie => {
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
    end

    render "chart_carreras"
  end

  def chart_foros
    #Buscamos si tengo los parametros de fechas    
    if (params[:initialDate].nil? or params[:finalDate].nil?)    
      @initialDate = "01/01/2015"   
      @finalDate = "01/12/2015"
    else      
      @initialDate = params[:initialDate]  
      @finalDate = params[:finalDate]   
    end  

    # Filtramos los comentarios por fecha
    @comments = Comment.where("created_at >= :initialDate AND created_at <= :finalDate", 
                                            {initialDate:  @initialDate, finalDate: @finalDate})

    # Filtramos las discusiones que no tengan comentarios en el rango de fechas
    @allDiscussions = Discussion.all
    @discussions = Array.new
    @allDiscussions.each do |discussion|
      discussionComments = discussion.comments.where("created_at >= :initialDate AND created_at <= :finalDate", 
                                            {initialDate:  @initialDate, finalDate: @finalDate})
      if (discussionComments.size > 0)
        @discussions.push discussion              
      end      
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
    @discussionNames = Array.new
    @discussions.each do |discussion|
      @discussionNames.push (discussion.subject + "-" + discussion.forum.group.name)
    end    
    
    @chart_foros = LazyHighCharts::HighChart.new('column') do |f|
          f.chart({
            :defaultSeriesType =>"column",
            :margin => [50, 200, 60, 170]
            })
          series = {
            :type => 'column',
            :name => 'Comentarios por discusión',
            :data => @discussionsActivityArray
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
    end

    render "chart_foros"
  end

  def chart_alumnos

  end

end
