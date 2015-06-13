class Admin::ReportesController < ApplicationController
  layout "administrator"

  # This is Devise's authentication
  before_filter :authenticate_admin!
  
  def chart_carreras

    @approved_users = User.all

    #consigo todas las carreras ( select distinct )
    @carreers_name = AcademicInfo.uniq.pluck(:carreer)

    @total_numer_of_approved_users = @approved_users.size

    #inicializo a todas las carreras en 0
    @carreers = Hash[@carreers_name.map {|v| [v, 0]}]

    #itero por todos los usuarios registrados y voy contando las carreras
    @approved_users.each do |user|
      @carreers[user.academic_info.carreer] += 1/Float( @carreers_name.size)
    end

    @carreers = @carreers.to_a

    @chart_carreras = LazyHighCharts::HighChart.new('pie') do |f|
          f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
          series = {
                   :type=> 'pie',
                   :name=> 'carreras',
                   :data=> @carreers
          }
          f.series(series)
          f.options[:title][:text] = "Carreras de Alumnos registrados en los ultimos 12 meses"
          f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
          f.plot_options(:pie=>{
            :allowPointSelect=>true, 
            :cursor=>"pointer" , 
            :dataLabels=>{
              :enabled=>true,
              :color=>"black",
              :style=>{
                :font=>"13px Trebuchet MS, Verdana, sans-serif"
              }
            }
          })
    end

    render "chart_carreras"
  end
end