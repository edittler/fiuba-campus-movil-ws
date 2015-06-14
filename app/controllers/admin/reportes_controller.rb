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
    @discussions = Discussion.all    
    @comments = Comment.all

    # Inicializo a todas las discusiones en 0
    @discussionsActivity = Hash[@discussions.map {|v| [v, 0]}]

    # Itero por todos los comentarios y voy contando las discusiones
    @comments.each do |comment|
      discussion = comment.discussion
      @discussionsActivity[discussion] += 1
    end
    @discussionsActivity = @discussionsActivity.to_a

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
            :name => 'discusiones',
            :data => @discussionsActivity
          }
          xAxis = {
            :categories => @discussionNames
          }
          f.xAxis(xAxis)
          f.series(series)
          f.options[:title][:text] = "Discusiones con mayor actividad"
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
