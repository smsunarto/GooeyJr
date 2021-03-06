module.exports = (robot) ->
  robot.respond /timezone (.*)/i, (msg) ->
    loc = msg.match[1]
    sender = msg.message.user.name
    msg.send("#{sender}: Fetching #{loc}'s timezone using Google API ;)")
    robot.http("https://maps.googleapis.com/maps/api/geocode/json?address=#{loc}&key=AIzaSyBd2bvRLgumW5AmSR5GNxCkeJSI7LXy3j8")
      .header('Accept', 'application/json')
      .get() (err, res, body) ->
        if err
          msg.send "Encountered an error :( #{err}"
          return

        data = JSON.parse body
        msg.send "[Timezone Logs] Fetching Geocode: #{data.results[0].geometry.location.lat},#{data.results[0].geometry.location.lng}"
        robot.http("https://maps.googleapis.com/maps/api/timezone/json?location=#{data.results[0].geometry.location.lat},#{data.results[0].geometry.location.lng}&timestamp=1331161200&key=AIzaSyCm5YZUGPtMiBl4lrxiNlvF_O915E-y_uI")
          .header('Accept', 'application/json')
          .get() (err, res, body) ->
            if err
              msg.send "Encountered an error :( #{err}"
              return

            tz = JSON.parse body
            msg.send "[Timezone Logs] Timezone: #{tz.timeZoneId},#{tz.timeZoneName}"