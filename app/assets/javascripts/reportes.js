// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//
//= require highcharts/highstock
//= require highcharts/highcharts-more
//= require highcharts/modules/exporting
//= require rgbcolor
//= require canvg
//= require jspdf


$(function(){

// create canvas function from highcharts example http://jsfiddle.net/highcharts/PDnmQ/
(function (H) {
    H.Chart.prototype.createCanvas = function (divId) {
        var svg = this.getSVG(),
            width = parseInt(svg.match(/width="([0-9]+)"/)[1]),
            height = parseInt(svg.match(/height="([0-9]+)"/)[1]),
            canvas = document.createElement('canvas');

        canvas.setAttribute('width', width);
        canvas.setAttribute('height', height);

        if (canvas.getContext && canvas.getContext('2d')) {

            canvg(canvas, svg);

            return canvas.toDataURL("image/jpeg");

        } 
        else {
            alert("Your browser doesn't support this feature, please use a modern browser");
            return false;
        }

    }
}(Highcharts));

	$("#export-carreras-to-pdf").on("click", exportCarrerasToPDF);

	function exportCarrerasToPDF(event) {
		var doc = new jsPDF();

		/*
		var elementHandler = {
			'#ignorePDF': function (element, renderer) {
				return true;
			}
		};
		var source = window.document.getElementById("chart-carreras");

		doc.fromHTML(
			source,
			15,
			15,
			{
				'width': 180,'elementHandlers': elementHandler
			});
		*/

		// http://stackoverflow.com/questions/25630811/export-highcharts-to-pdf-using-javascript-and-local-server-no-internet-connec

		// chart height defined here so each chart can be palced
		// in a different position
		var chartWidth = 120;
		var chartHeight = 80;
		var chartScale = 2;

		$('#chart-carreras').each(function (index) {
			var imageData = $(this).highcharts().createCanvas();

			// add image to doc, if you have lots of charts, you will need
			// to check if you have gone bigger than a page and do
			// doc.addPage() before adding another image.

			//addImage(imagedata, type, x, y, width, height)
			doc.addImage(
				imageData,
				'JPEG',
				0,
				(index * chartHeight * chartScale) + 40,
				chartWidth * chartScale,
				chartHeight * chartScale
			);
		});

		doc.output("dataurlnewwindow");
	}

});