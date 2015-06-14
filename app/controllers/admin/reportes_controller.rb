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

  end

  def chart_alumnos

  end

end
