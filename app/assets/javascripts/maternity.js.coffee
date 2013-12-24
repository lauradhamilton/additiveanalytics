jQuery ->
  $('#maternity').dataTable
    "sPaginationType": "full_numbers",
    "sAjaxSource": "/data/maternity.json",
    "aoColumnsDefs": [
      {"mData": "State" },
      {"mData": "Hospital Name"},
      {"mData": "Percent of Newborns Delivered Early"}
      ]
