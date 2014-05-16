$(document).ready ->
  oTable = $("#compare_prices").dataTable(
    "iDisplayLength": 50
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
  ).columnFilter(
       sPlaceHolder: "head:after",
       aoColumns: [
         {type: "select", values: ["AL","AK","AS","AZ","AR","CA","CO","CT","DE","DC","FM","FL","GA","GU","HI","ID","IL","IN","IA","KS","KY","LA","ME","MH","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","MP","OH","OK","OR","PW","PA","PR","RI","SC","SD","TN","TX","UT","VT","VI","VA","WA","WV","WI","WY"]},
         {type: "text"},
         {type: "text"},
         {type: "null"}
       ]
    )
  return

