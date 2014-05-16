$(document).ready ->
  oTable = $("#compare_prices").dataTable(
    bProcessing: true
    sAjaxSource: "compare_prices_data"
    aoColumns: [
      {
        mDataProp: "state"
      }
      {
        mDataProp: "provider_name"
      }
      {
        mDataProp: "procedure_type"
      }
      {
        mDataProp: "procedures_count"
      }
      {
        mDataProp: "average_cost"
      }
    ]
  )
  return

