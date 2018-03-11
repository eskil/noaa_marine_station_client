defmodule NoaaMarineStationClient.Client.Mock do
  # Module must adhere to the NoaaMarineStationClient.Client API
  @behaviour NoaaMarineStationClient.Client

  def read_station(station_id, _opts \\ [])

  def read_station("bad id", _opts) do
    %{
      status_code: 404
    }
  end

  def read_station(_, _opts) do
    %{
      status_code: 200,
      body: """
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN"><html><head>
<title>Coastal Waters Forecast for Coastal Waters from Point Reyes to Pigeon Point California out to 10 nm (PZZ545)</title><link rel="STYLESHEET" type="text/css" href="fonts/main.css"><script type="text/javascript"> var smap=1; var gmsite = 'mtr'; var gmscale =8; var gmsi=0; var gmlng='en'; </script></head><body bgcolor="#EEEEEE"><div id="container"><table align="center" cellspacing="0" cellpadding="0" border="0" width="670" background="/images/wtf/topbanner.jpg"><tr><td height="19">&nbsp;&nbsp;&nbsp;</td></tr></table><table align="center" cellspacing="0" cellpadding="0" border="0" width="670"><tr valign="top"><td rowspan="2"><a href="http://www.noaa.gov"><img src="/images/wtf/noaaleft.jpg" alt="NOAA logo - Click to go to the NOAA homepage" title="NOAA logo - Click to go to the NOAA homepage" width="85" height="78" border="0"></a></td><td height="20"><img src="/images/wtf/forecast_title.jpg" alt="Your National Weather Service forecast" title="Your National Weather Service forecast" width="500" height="20" border="0"></td><td rowspan="2" align="right"><a href="http://weather.gov"><img src="/images/wtf/nwsright.jpg" alt="NWS logo" title="NWS logo" width="85" height="78" border="0"></a></td></tr><tr align="center"><td background="/images/wtf/forecast_blank.jpg" height="57" class="white1"><font size="3">Coastal Waters from Point Reyes to Pigeon Point California out to 10 nm (PZZ545) - Pacific Ocean</font><a href="#contents"><img src="/images/wtf/skipgraphic.gif" alt="Skip to Detailed 7-Day Forecast" title="Skip to Detailed 7-Day Forecast" width="1" height="1" border="0"></a></td></tr></table><table align="center" cellspacing="0" cellpadding="0" border="0" background="/images/wtf/navbkgrnd.gif" width="670"><tr><td><img src="/images/wtf/navbarleft.jpg" alt="" width="94" height="23" border="0"></td><td align="left" class="searchinput"><form method="POST" action="http://forecast.weather.gov/zipcity.php" style="display:inline"><span class="yellow">Enter Your &quot;City, ST&quot; or zip code </span><span class="searchinput"><input type="text" name="inputstring" size="15" value=""></span>&nbsp;&nbsp; <INPUT TYPE="submit" NAME="Go2"
 VALUE="Go"></form></td><td align="right"><a class="addthis_button" href="http://addthis.com/bookmark.php?v=250&pub=xa-4b05b2d91f18c9cc"><img src="http://s7.addthis.com/static/btn/v2/lg-bookmark-en.gif" width="125" height="16" alt="Bookmark and Share" style="border:0"/></a><script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pub=xa-4b05b2d91f18c9cc"></script><script type="text/javascript">
var addthis_config = {
     ui_delay: 400
}
</script>&nbsp;</td></tr></table>
<table align="center" width="670" border="0" align="left">
<tr><td>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0"><tr><td align="left" valign="center" width="50%"><a href=http://www.wrh.noaa.gov/mtr>NWS San Francisco Bay Area/Monterey, CA</a><br><b>Zone Forecast: </b><font size="2">Coastal Waters from Point Reyes to Pigeon Point California out to 10 nm (PZZ545)</font></td><td align="right" valign="bottom" width="50%"><a href="http://www.srh.noaa.gov/cte.htm"><b>Mobile Weather Information</b></a><br><br><a href="http://www.weather.gov/glossary/index.php?word=Last+update"><b>Last Update:</b></a> 256 AM PDT MON JUN 20 2016<br></td>
</tr>
</table>
</td></tr>
<tr><td>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr valign ="top">
<td valign="top" align="left" width="50%">
<img alt="Marine Zone Forecast" title="Marine Zone Forecast" src="/images/wtf/marinezonebanner.jpg"><br><a name="contents"></a>

<b>Synopsis</b>...GREATER FARALLONES...AND CORDELL BANK
NATIONAL MARINE SANCTUARIES...<br><br>HIGH PRESSURE OVER THE EASTERN PACIFIC WILL MAINTAIN A STRONG
SURFACE PRESSURE GRADIENT ACROSS THE COASTAL WATERS. STRONG
NORTHERLY WINDS EXPECTED THROUGH MUCH OF THE WEEK WITH THE
STRONGEST WINDS ANTICIPATED OVER THE OFFSHORE WATERS AND ALONG
THE BIG SUR COAST. THE STRONG WINDS WILL PRODUCE A FRESH SWELL.

<br><hr><b>Today</b>...NW winds 10 to 20 kt. Wind waves 2 to 4 ft. NW swell 5 to 7 ft at 8 seconds.<br><br><b>Tonight</b>...NW winds 10 to 20 kt. Wind waves 2 to 4 ft. NW swell 6 to 8 ft at 8 seconds.<br><br><b>Tue</b>...NW winds 10 to 20 kt. Wind waves 2 to 4 ft. NW swell 6 to 8 ft at 8 seconds. Patchy fog in the morning.<br><br><b>Tue Night</b>...NW winds 15 to 25 kt. Wind waves 3 to 5 ft. NW swell 6 to 8 ft at 8 seconds. Patchy fog after midnight.<br><br><b>Wed</b>...NW winds 15 to 25 kt. Wind waves 3 to 5 ft. NW swell 6 to 8 ft at 8 seconds and SW 3 ft at 20 seconds. Patchy night and morning fog.<br><br><b>Thu</b>...NW winds 15 to 25 kt. Wind waves 3 to 5 ft. W swell 6 to 8 ft and SW 3 ft. Patchy fog.<br><br><b>Fri</b>...NW winds 15 to 25 kt. Wind waves 3 to 5 ft. W swell 6 to 8 ft and SW 3 ft. Patchy fog.<br><br> .....san francisco bar/fourfathom bank forecast.....<br><br> in the deep water channel...combined seas 4 to 5 feet at 14 seconds.<br><br> across the bar...maximum ebb current of 3.3 knots at 04:25 am monday and 1.3 knots at 05:43 pm monday.<br><br><br><br><br><br></td>
<td valign="top" align="center" width="50%">
<img src="/images/wtf/dpoint_forecast_down.jpg" width="326" height="20" border="0" alt="Detailed Point Forecasts" title="Detailed Point Forecasts" usemap="#dpbanner"><map name="dpbanner">
<area shape="rect" coords="268,0,325,19" href="/MapClick.php?zoneid=PZZ545&mp=1" alt="Move point forecast map down, and current conditions, radar, and satellite up." title="Move point forecast map down, and current conditions, radar, and satellite up." title="Move point forecast map down, and current conditions, radar, and satellite up." title="Move point forecast map down, and current conditions, radar, and satellite up."></map><img src="/images/wtf/currentconds_up.jpg" width="326" height="20" border="0" alt="Current Local Weather" title="Current Local Weather" usemap="#ccbanner"><map name="ccbanner"><area shape="rect" coords="268,0,325,19" href="/MapClick.php?zoneid=PZZ545&mp=1" alt="Move point forecast map down, and current conditions, radar, and satellite up." title="Move point forecast map down, and current conditions, radar, and satellite up." title="Move point forecast map down, and current conditions, radar, and satellite up." title="Move point forecast map down, and current conditions, radar, and satellite up."></map><table cellspacing="0" cellspacing="0" border="0" width="100%"><tr align="center"><td><span class="blue1">46026 SAN FRANCISCO - 18NM West of San Francisco</span><br>Lat: 37.76&deg;N &nbsp; Lon: 122.83&deg;W &nbsp; Elev: 0<br><font color="#FF0000"><br>Not a Current Observation<br><br></font></td></tr><tr><td colspan="2"><table cellspacing="0" cellpadding="0" border="0"><tr><td width="105" align="center"><a href="http://www.ndbc.noaa.gov/radial_search.php?lat1=37.66880N&lon1=122.70800W&uom=E&dist=50" class="link"><b>Nearby<br>Observations</b></a><br><br><a href="http://www.ndbc.noaa.gov/station_page.php?station=46026" class="link"><b>Past<br>Observations</b></a></td>
 <td rowspan="2" width="215"><table cellspacing="0" cellpadding="2" border="0" width="100%">

 <tr bgcolor="#b0c4de">
 <td><b>Wind</b>:</td>
 <td align="right" nowrap>NA</td>
 </tr>
 <tr bgcolor="#ffefd5">
 <td><b>Pressure</b>:</td>
 <td align="right" nowrap>NA</td>
 </tr>
 <tr bgcolor="#b0c4de">
 <td><b>Air Temperature</b>:</td>
 <td align="right" nowrap>NA</td>
 </tr>
 <tr bgcolor="#ffefd5">
 <td><b>Water Temperature</b>:</td>
 <td align="right" nowrap>NA</td>
 </tr>
 <tr bgcolor="#b0c4de">
 <td><b>Dewpoint</b>:</td>
 <td align="right" nowrap>NA</td>
 </tr>
 <tr bgcolor="#ffefd5">
 <td><b>Wave Hgt/Dir</b>:</td>
 <td align="right" nowrap>NA</td>
 </tr>
 <tr bgcolor="#b0c4de">
 <td><b>Dominant Wave Period</b>:</td>
 <td align="right" nowrap>NA</td>
 </tr>
 <tr bgcolor="#ffefd5">
 <td><b>Visibility</b>:</td>
 <td align="right" nowrap>NA</td>
 </tr><tr><td><br></td></tr></table></td></tr>

	    </table></td>
</tr><tr valign ="top"><td valign="top" align="center" width="50%"><img title="Radar and Satellite (Click for larger image)" alt="Radar and Satellite (Click for larger image)" src="/images/wtf/radandsat.jpg"><br><a href="http://radar.weather.gov/radar.php?rid=mux&product=N0R&overlay=11101111&loop=no"><img src="http://radar.weather.gov/Thumbs/MUX_Thumb.gif" width="130" height="130" border="0" alt="Link to Local Radar Data" title="Link to Local Radar Data"></a>&nbsp;<a href="http://www.wrh.noaa.gov/satellite/?wfo=mtr"><img src="http://sat.wrh.noaa.gov/satellite/4km/WR/IR4.thumbnail.jpg" width="173" height="130" border="0" alt="Link to Satellite Data" title="Link to Satellite Data"></a><br><br></td></tr></table></td></tr>
<tr valign ="top">
<td valign="top" align="left" width="50%">
<img alt="National Digital Forecast Database (Click for larger image)" title="National Digital Forecast Database (Click for larger image)" src="/images/wtf/ndfd-banner.jpg"><br><a href="http://www.weather.gov/forecasts/graphical/sectors/pacsouthwestMarineDay.php?element=WaveHeight"><img src="http://www.weather.gov/forecasts/graphical/images/thumbnail/Thumbnail_WaveHeight1_pacsouthwest.png" border="0" alt="National Digital Forecast Database Wave Height Forecast" title="National Digital Forecast Database Wave Height Forecast"></a><a href="http://www.weather.gov/forecasts/graphical/sectors/pacsouthwestMarineDay.php?element=WindSpd"><img src="http://www.weather.gov/forecasts/graphical/images/thumbnail/Thumbnail_WindSpd1_pacsouthwest.png" border="0" alt="National Digital Forecast Database Wind Speed Forecast" title="National Digital Forecast Database Wind Speed Forecast"></a>

</td>
<td valign="top" align="left" width="50%">
 <img alt="Additional Forecasts and Information" title="Additional Forecasts and Information" src="/images/wtf/addinfosml.jpg">
 <br>
 <table cellspacing="0" cellpadding="1" border="0" width="320">
<tr bgcolor="#b0c4de"><td colspan="2" align="center"><a href="http://forecast.weather.gov/product.php?site=NWS&issuedby=MTR&product=AFD&format=CI&version=1&glossary=1">Forecast Discussion</a></td></tr><tr bgcolor="ffefd5"><td><a href="http://www.nws.noaa.gov/om/marine/home.htm">National Marine Forecasts</a></td><td><a href="http://tidesandcurrents.noaa.gov/tides18/tpred2.html#CA">Tide Information</a></td></tr><tr bgcolor="#b0c4de"><td align="left"><a href="/MapClick.php?zoneid=PZZ545&TextType=1" target="_blank">Printable Forecast</a></td>
<td align="left"><a href="/MapClick.php?zoneid=PZZ545&TextType=1" target="_blank">Text Only Forecast</a></td>
</tr>
<tr bgcolor="#ffefd5"><td align="left"><a href="http://www.wrh.noaa.gov/mtr/versprod.php?pil=RR8&sid=RSA" target="_self">Hourly River Stages</a></td><td align="left"><a href="http://www.wrh.noaa.gov/mtr/versprod.php?pil=RR5&sid=RSA" target="_self">Hourly Rainfall</a></td></tr>
<tr bgcolor="#b0c4de"><td align="left"><a href="http://www.wrh.noaa.gov/mtr/wxlinks.php" target="_self">NWS Office Map</a></td><td align="left"><a href="http://www.wrh.noaa.gov/mtr/weather_calc.php" target="_self">Weather Calculator</a></td></tr>
</table></td></tr><tr valign="top"><td class="gray" align="left" colspan="2"><table border="0" width="100%"><tr><td colspan="3"><hr width="100%" size="2" noshade></td></tr><tr valign="top"><td class="gray" align="left" width="40%"><a href="mailto:w-mtr.webmaster@noaa.gov">Webmaster</a><br>National Weather Service:<br> San Francisco Bay Area/Monterey, CA</td><td align="center" width="30%"><form><input type="button" value="Back to Previous Page" onClick="history.back()"></form></td><td align="right" width="30%" class="gray"><a href="http://www.weather.gov"<u>www.weather.gov</u></a><br><a href="http://weather.gov/privacy.php">Privacy Policy</a><br><a href="http://weather.gov/disclaimer.php">Disclaimer</a><br><a href="http://www.weather.gov/credits.php#socialmedia">Credits</a><br></td></tr></table></td></tr></table></td></tr></table></div>
</body>
</html>
"""
    }
  end

  def read_station_list(_opts \\ [])

  def read_station_list([mock_fail: true]) do
    %{
      status_code: 500
    }
  end

  def read_station_list(_opts) do
    %{
      status_code: 200,
      body: """
      """
    }
  end
end
