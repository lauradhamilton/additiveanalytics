jQuery ->
  $('#maternity').dataTable(
    "sDom": 'RfClrtip',
    "iDisplayLength": 50
    "sPaginationType": "full_numbers",
    "sAjaxSource": "/data/maternity.json",
    "aaSorting": [[2, "desc" ]]
    "aoColumnsDefs": [
      {"mData": "State" },
      {"mData": "Hospital Name"},
      {"mData": "Percent of Newborns Delivered Early"}
      ]
    ).columnFilter(
       aoColumns: [
         type: "select", values: ['AL','IL']
         null,
         null
       ]
    )    
