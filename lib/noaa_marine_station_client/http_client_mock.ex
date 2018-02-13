defmodule TwscClient.HttpClientMock do

  def login(_, "valid") do
    %{
      status_code: 200,
      headers: %{"set-cookie" => ["cookie", "PHPSESSID=valid-session-id"]}
    }
  end

  def login(_, _) do
    # TODO: what is the actual error code returned by TWSC?
    %{ status_code: 404 }
  end

  def logout("valid-session-id") do
    %{ status_code: 200 }
  end

  def logout(_) do
    # TODO: what is the actual error code returned by TWSC?
    %{ status_code: 404 }
  end

  def reservations("valid-session-id") do
    %{
      status_code: 200,
      body: """
            <!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN"><html><head><title>Coastal Waters Forecast for Coastal Waters from Point Reyes to Pigeon Point California out to 10 nm (PZZ545) (Text-Only)</title></head><body leftmargin="0" topmargin="0" rightmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF" text="#000000"><div style="margin:25px 0px 0px 0px;"><table width="800" border="0" align="center" cellpadding="0" cellspacing="0"><tr valign ="top"><td width="80%" valign="top" align="left"><font size="3"><b>NWS Forecast for: <font size="3">Coastal Waters from Point Reyes to Pigeon Point California out to 10 nm (PZZ545)</font></b></font><br>Issued by: National Weather Service San Francisco Bay Area/Monterey, CA<br><a href="http://www.weather.gov/glossary/index.php?word=Last+update"><b>Last Update: </b></a>225 AM PST Tue Feb 13 2018</td></tr><tr><td colspan="2" valign="top" align="center"><hr><br></td></tr>
            </table><table width="800" border="0" align="center" cellpadding="0" cellspacing="0"><tr valign ="top"><td colspan="2" valign="top" align="left"><b>Today: </b>NE winds 15 to 25 kt...decreasing to 5 to 15 kt in the afternoon. Wind waves 3 to 5 ft. NW swell 4 to 6 ft at 12 seconds. <br>
            <br>
            <b>Tonight: </b>NW winds 5 to 15 kt...becoming SW 5 kt after midnight. Wind waves 3 to 4 ft. NW swell 4 to 5 ft at 16 seconds. <br>
            <br>
            <b>Wed: </b>SW winds 10 kt...becoming NW in the afternoon. Wind waves 3 to 4 ft. NW swell 3 to 5 ft at 15 seconds. <br>
            <br>
            <b>Wed Night: </b>NW winds 10 to 20 kt. Wind waves 2 to 4 ft. NW swell 3 to 5 ft at 15 seconds. <br>
            <br>
            <b>Thu: </b>N winds 5 to 15 kt. Wind waves 1 to 3 ft. NW swell 3 to 5 ft at 15 seconds. <br>
            <br>
            <b>Fri: </b>NW winds 5 to 15 kt. Wind waves 1 to 3 ft. NW swell 3 to 5 ft. <br>
            <br>
            <b>Sat: </b>NW winds 10 to 20 kt. Wind waves 2 to 4 ft. NW swell 3 to 5 ft.    .....san francisco bar/fourfathom bank forecast.....  in the deep water channel...combined seas 5 to 7 ft at 12 seconds.  across the bar...combined seas 6 to 8 ft at 12 seconds. Maximum ebb current of 1.6 knots at 02:49 am tuesday and 2.3 knots at 02:49 pm tuesday.  <br>
  <br>
  <hr><br></td></tr>
 """
    }
  end
end
