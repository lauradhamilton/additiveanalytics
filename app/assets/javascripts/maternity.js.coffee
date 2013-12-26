jQuery ->
  $('#maternity').dataTable
    "sPaginationType": "full_numbers",
    "sAjaxSource": "/data/maternity.json",
    "aaSorting": [[2, "desc" ]]
    "aoColumnsDefs": [
      {"mData": "State" },
      {"mData": "Hospital Name"},
      {"mData": "Percent of Newborns Delivered Early"}
      ]
