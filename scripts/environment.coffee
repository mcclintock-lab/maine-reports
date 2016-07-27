ReportTab = require 'reportTab'
templates = require '../templates/templates.js'
d3 = window.d3

_partials = require '../node_modules/seasketch-reporting-api/templates/templates.js'
partials = []
for key, val of _partials
  partials[key.replace('node_modules/seasketch-reporting-api/', '')] = val


class EnvironmentTab extends ReportTab
  name: 'Environment'
  className: 'environment'
  template: templates.environment
  dependencies:[ 
    'MaineHabitat'
  ]

  render: () ->

    habitats = @recordSet('MaineHabitat', 'MaineHabitats').toArray()
    @roundData habitats
    habitats = _.sortBy habitats, (row) -> row.Name

    # setup context object with data and render the template from it
    context =
      sketch: @model.forTemplate()
      sketchClass: @sketchClass.forTemplate()
      attributes: @model.getAttributes()
      admin: @project.isAdmin window.user

      habitats: habitats
    
    @$el.html @template.render(context, templates)
    @enableLayerTogglers()
    @enableTablePaging()

  roundData: (data) =>
    for d in data
      try
        d.AREA = parseFloat(d.AREA).toFixed(1)
      catch
        d.AREA = 0.0

module.exports = EnvironmentTab