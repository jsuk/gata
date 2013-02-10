# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
leap = (year) ->
  (if year % 4 then 0 else (if year % 100 then 1 else (if year % 400 then 0 else 1)))

#0 for SUN , 1 for MON and so on
make_cal_array = (year) ->
  months = [31, 28 + leap(year), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  result = []
  m = 0

  while m < 12
    result[m] = []
    dofw1 = (new Date(year, m, 1, 0, 0, 0)).getDay()
    dofw1 = (dofw1 + (7 - weekdayToStart)) % 7
    d = 1

    while d <= months[m]
      result[m][d + dofw1 - 1] = d
      d++
    m++
  result
weekdayToStart = 1
weekdayToEnd = (weekdayToStart + 6) % 7

make_cal_yearly = (year) ->
  cal = make_cal_array(year)
  tbody = document.createElement("tbody")
  m = 0

  while m < 12
    tr = document.createElement("tr")
    th = document.createElement("th")
    th.innerHTML = m + 1
    tr.appendChild th
    d = 0
    l = cal[m].length

    while d < l
      td = document.createElement("td")
      if cal[m][d]
        td.innerHTML = cal[m][d]
        td.className = daynames[d % 7].toLowerCase()
        #console.log cal[m][d] + ": " + td.className
      tr.appendChild td
      d++
    tbody.appendChild tr
    m++
  table = document.createElement("table")
  table.className = "ycal"
  caption = document.createElement("caption")
  caption.innerHTML = year
  table.appendChild caption
  table.appendChild tbody
  table
daynames = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
monthNames = ["JANUARY", "FEBUARY", "MARCH", "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"]
holidays = [[1, 2, 3, 14], [11], [20], [29], [3, 4, 5, 6], [], [15], [], [16, 23], [14], [3, 4, 23], [23, 31]]

make_cal_monthly = (year, m) ->
  cal = make_cal_array(year)
  table = document.createElement("table")
  
  # header
  tr = document.createElement("tr")
  d = weekdayToStart

  while d < weekdayToStart + 7
    th = document.createElement("th")
    th.innerHTML = daynames[d % 7]
    th.className = daynames[d % 7].toLowerCase()
    tr.appendChild th
    d++
  thead = document.createElement("thead")
  thead.appendChild tr
  table.appendChild thead
  
  # body;
  tbody = document.createElement("tbody")
  weekCount = 0
  d = 0
  l = cal[m].length

  while d < l
    trbody = document.createElement("tr")  if d % 7 is 0
    td = document.createElement("td")
    if cal[m][d]
      dayNumber = document.createElement("span")
      dayNumber.className = "dayNumber"
      dayNumber.innerHTML = cal[m][d]
      
      #td.innerHTML = cal[m][d];
      td.appendChild dayNumber
      td.className = daynames[(d + weekdayToStart) % 7].toLowerCase()
      #console.log cal[m][d] + "(" + d + "): " + td.className
      h = 0
      hl = holidays[m].length

      while h < hl
        
        console.log(monthNames[m],holidays[m][h] , d);
        if holidays[m][h] is cal[m][d]
          td.className = "hol"
          break
        h++
    else
      #console.log cal[m][d] + "(" + d + "): "
    trbody.appendChild td
    if d % 7 is weekdayToEnd
      tbody.appendChild trbody
      weekCount++
    d++
  tbody.appendChild trbody
  weekCount++
  #console.log m + " week count " + weekCount
  if weekCount <= 5
    blankd = document.createElement("td")
    xx = document.createElement("tr")
    xx.appendChild blankd
    tbody.appendChild xx
  table.className = "mcal"
  caption = document.createElement("caption")
  month = document.createElement("span")
  yearPostfix = document.createElement("span")
  month.className = monthName(m) + ' monthName'
  month.innerHTML = " " + monthName(m)
  yearPostfix.className = "yearName"
  yearPostfix.innerHTML = year
  caption.innerHTML = (m + 1)
  caption.appendChild month
  caption.appendChild yearPostfix
  table.appendChild caption
  table.appendChild tbody
  table
monthName = (month) ->
  monthNames[month]

make_calendars = (year, p) ->
  
  #p.innerHTML = '';
  #p.appendChild(make_cal_yearly(year));
  m = 0

  while m < 12
    mcal = make_cal_monthly(year, m)
    order = (m % 4)
    if order is 0
      mcal.className = mcal.className + " tableHeadPadding"
      row = document.createElement("div")
    else if order is 3
      mcal.className = mcal.className + " tableTailPadding"
    else
      mcal.className = mcal.className + " tablePadding"
    row.appendChild mcal
    if m % 4 is 3
      br = document.createElement("br")
      br.clear = "all"
      row.className = "monthRow"
      p.appendChild row
    m++
  
  #if( m != 11 ) { p.appendChild(br); }
  br = document.createElement("br")
  br.clear = "all"
  p.appendChild br

init = ->
  o = document.getElementById("cal")
  y = document.getElementById("yearinheader")
  #console.log o
  #console.log y.innerHTML
  year = parseInt(y.innerHTML)
  #y.innerHTML = year.toString()
  console.log year
  make_calendars year, o
daynames_es = ["Dom", "Lun", "Mar", "Mié", "Jue", "Vie", "Sáb"]
daynames_fr = ["Dim", "Lun", "Mar", "Mer", "Jeu", "Ven", "Sam"]
monthNames_es = ["enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"]
monthNames_fr = ["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"]
$ ->
  init()
  days = document.getElementsByTagName('th')
  months = document.getElementsByClassName('monthName')
  console.log months
  spanish.onclick = ->
    for day in days
      index = daynames.indexOf(day.className.toUpperCase())
      day.innerHTML = daynames_es[index].toUpperCase()
    for month in months
      index = monthNames.indexOf(month.className.replace(/\s*monthName\s*/g,'').toUpperCase())
      month.innerHTML = ' ' + monthNames_es[index].toUpperCase()
  english.onclick = ->
    for day in days
      index = daynames.indexOf(day.className.toUpperCase())
      day.innerHTML = daynames[index]
    for month in months
      index = monthNames.indexOf(month.className.replace(/\s*monthName\s*/g,'').toUpperCase())
      month.innerHTML = ' ' + monthNames[index].toUpperCase()
  french.onclick = ->
    for day in days
      index = daynames.indexOf(day.className.toUpperCase())
      day.innerHTML = daynames_fr[index].toUpperCase()
    for month in months
      index = monthNames.indexOf(month.className.replace(/\s*monthName\s*/g,'').toUpperCase())
      month.innerHTML = ' ' + monthNames_fr[index].toUpperCase()
