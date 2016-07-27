ReportTab = require 'reportTab'
templates = require '../templates/templates.js'
d3 = window.d3

_partials = require '../node_modules/seasketch-reporting-api/templates/templates.js'
partials = []
for key, val of _partials
  partials[key.replace('node_modules/seasketch-reporting-api/', '')] = val


class OverviewTab extends ReportTab
  name: 'Overview'
  className: 'overview'
  template: templates.overview
  dependencies:[ 
    'SizeToolbox'
    'ShellfishAndAquaculture'
  ]

  render: () ->
    size = @recordSet('SizeToolbox', 'Size').float('Size')
    aquaculture = @recordSet('ShellfishAndAquaculture', 'Aquaculture').toArray()
    shellfish = @recordSet('ShellfishAndAquaculture', 'Shellfish').toArray()
    console.log("aq: ", aquaculture)
    # setup context object with data and render the template from it
    context =
      sketch: @model.forTemplate()
      sketchClass: @sketchClass.forTemplate()
      attributes: @model.getAttributes()
      admin: @project.isAdmin window.user
      size: size
      aquaculture: aquaculture
      shellfish: shellfish
    
    @$el.html @template.render(context, templates)
    @enableLayerTogglers()



module.exports = OverviewTab