jQuery ->
  $('#maternity').dataTable({
    "sPaginationType": "full_numbers"
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": "/data/maternity.json"
    });
