jQuery ->
  $('#readmissions').dataTable(
    "sDom": 'RClrtip',
    "iDisplayLength": 50
    "sPaginationType": "full_numbers",
    "sAjaxSource": "/data/readmissions.json",
    "bAutoWidth": false
    "aaSorting": [[8, "desc" ]]
    "aoColumnsDefs": [
      {"mData": "State" },
      {"mData": "Hospital Name"},
      {"mData": "Heart Attack Readmissions"},
      {"mData": "Heart Failure Readmissions"},
      {"mData": "Pneumonia Readmissions"},
      {"mData": "Heart Attack Payment Adjustment"},
      {"mData": "Heart Failure Payment Adjustement"},
      {"mData": "Pneumonia Payment Adjustment"},
      {"mData": "Quality Score"},
      {"mData": "Grade"}
      ]
    ).columnFilter(
       sPlaceHolder: "head:after",
       aoColumns: [
         {type: "select", values: ["AL","AK","AS","AZ","AR","CA","CO","CT","DE","DC","FM","FL","GA","GU","HI","ID","IL","IN","IA","KS","KY","LA","ME","MH","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","MP","OH","OK","OR","PW","PA","PR","RI","SC","SD","TN","TX","UT","VT","VI","VA","WA","WV","WI","WY"]},
         {type: "text"},
         {type: "null"},
         {type: "null"},
         {type: "null"},
         {type: "null"},
         {type: "null"},
         {type: "null"},
         {type: "null"},
         {type: "select", values: ["A","B","C","D"]}
       ]
    )    
