defmodule NoaaMarineStationClient.Client.Mock do
  # Module must adhere to the NoaaMarineStationClient.Client API
  @behaviour NoaaMarineStationClient.Client

  def fetch_station_data(station_id, _opts \\ [])

  def fetch_station_data("bad id", _opts) do
    %{
      status_code: 404
    }
  end

  def fetch_station_data("PZZ545", _opts) do
    %{
      status_code: 200,
      body: """
      <title>Coastal Waters Forecast for Coastal Waters from Point Reyes to Pigeon Point California out to 10 nm (PZZ545) (Text-Only)</title>
      <link rel="STYLESHEET" type="text/css" href="fonts/main.css">
      </head>
      <body leftmargin="0" topmargin="0" rightmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF">
      <br>

      <table width="670" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr valign ="top">
      <td width="80%" valign="top" align="left"><font size="3"><b>NWS Zone Forecast for: Coastal Waters from Point Reyes to Pigeon Point California out to 10 nm - Pacific Ocean</b></font><br>
      Issued by: National Weather Service San Francisco Bay Area/Monterey, CA<br><a href="http://www.weather.gov/glossary/index.php?word=Last+update"><b>Last Update: </b></a>256 AM PDT MON JUN 20 2016</td>
      <td width="20%" valign="top" align="right">
      <a href=javascript:window.print()><img src="/images/wtf/12.gif" border=0 height=35 width=30 alt=Print></a>
      </td>
      </tr>
      <tr>
      <td colspan="2" valign="top" align="center"><hr><br></td>
      </tr>
      </table>
      <table width="670" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr valign ="top">
      <td valign="top" align="left" colspan="2">
      <br><b>Synopsis</b>...GREATER FARALLONES...AND CORDELL BANK
      NATIONAL MARINE SANCTUARIES...<br><br>HIGH PRESSURE OVER THE EASTERN PACIFIC WILL MAINTAIN A STRONG
      SURFACE PRESSURE GRADIENT ACROSS THE COASTAL WATERS. STRONG
      NORTHERLY WINDS EXPECTED THROUGH MUCH OF THE WEEK WITH THE
      STRONGEST WINDS ANTICIPATED OVER THE OFFSHORE WATERS AND ALONG
      THE BIG SUR COAST. THE STRONG WINDS WILL PRODUCE A FRESH SWELL.

      <br><hr><b>Today</b>...NW winds 10 to 20 kt. Wind waves 2 to 4 ft. NW swell 5 to 7 ft at 8 seconds.<br><br><b>Tonight</b>...NW winds 10 to 20 kt. Wind waves 2 to 4 ft. NW swell 6 to 8 ft at 8 seconds.<br><br><b>Tue</b>...NW winds 10 to 20 kt. Wind waves 2 to 4 ft. NW swell 6 to 8 ft at 8 seconds. Patchy fog in the morning.<br><br><b>Tue Night</b>...NW winds 15 to 25 kt. Wind waves 3 to 5 ft. NW swell 6 to 8 ft at 8 seconds. Patchy fog after midnight.<br><br><b>Wed</b>...NW winds 15 to 25 kt. Wind waves 3 to 5 ft. NW swell 6 to 8 ft at 8 seconds and SW 3 ft at 20 seconds. Patchy night and morning fog.<br><br><b>Thu</b>...NW winds 15 to 25 kt. Wind waves 3 to 5 ft. W swell 6 to 8 ft and SW 3 ft. Patchy fog.<br><br><b>Fri</b>...NW winds 15 to 25 kt. Wind waves 3 to 5 ft. W swell 6 to 8 ft and SW 3 ft. Patchy fog.<br><br> .....san francisco bar/fourfathom bank forecast.....<br><br> in the deep water channel...combined seas 4 to 5 feet at 14 seconds.<br><br> across the bar...maximum ebb current of 3.3 knots at 04:25 am monday and 1.3 knots at 05:43 pm monday.<br><br><br><br><br><br><hr><br>
      </td></tr>
      <tr>
      <td align="left"><br></td>
      <td align="right"><br></td>
      </tr>
      <tr>
      <td colspan="2" align="left">
      <br>
      Visit your local NWS office at: <a href="http://www.wrh.noaa.gov/mtr">http://www.wrh.noaa.gov/mtr</a></td>
      </tr>
      </table>
      </body>
      </html>
      """
    }
  end
end
