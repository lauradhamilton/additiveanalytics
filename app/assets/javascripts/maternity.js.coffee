jQuery ->
  $('#maternity').dataTable(
    "sDom": 'RClrtip',
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
       sPlaceHolder: "head:after",
       aoColumns: [
         {type: "select", values: ["AL","AK","AS","AZ","AR","CA","CO","CT","DE","DC","FM","FL","GA","GU","HI","ID","IL","IN","IA","KS","KY","LA","ME","MH","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","MP","OH","OK","OR","PW","PA","PR","RI","SC","SD","TN","TX","UT","VT","VI","VA","WA","WV","WI","WY"]},
         {type: "text"},
         {type: "number"}
       ]
    )    
