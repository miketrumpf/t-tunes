//
//  LyricsContentManager.swift
//  TTunes
//
//  Created by Mike on 9/27/17.
//

import Foundation
import UIKit


class LyricsContentManager: NSObject {

  
  static func fetchLyrics(song: String, artist: String, withCompletion completion: @escaping (String?) -> Void) {

    LyricsAPIManager.fetchLyricsWithCompletion(song: song, artist: artist, comp: { lyricString in
      
      //response string from api is very messy if parsing fails error will be thrown
      var lyrics = ""
      //super hacky and ugly parsing of this response string.  if I had more time I would convert the string to a json object and then just grab the lyrics value.
      //with the lyrics value I would be able to run a better check if it turns out to be not found
      
      //cut off the song = at begginning to be able to substring contents within brackets
      if let index = (lyricString?.range(of: "song = ")?.upperBound) {
        var afterEqualsTo = String(describing: lyricString!.substring(from: index))
        //get rid of surrounding brackets
        let dropFirst = String(afterEqualsTo.dropFirst())
        let droppedLast = String(dropFirst.dropLast(2))
        //get substring after the lyrics key
        if let newIndex = (droppedLast.range(of: "lyrics':")?.upperBound) {
          let afterLyrics = String(droppedLast.substring(from: newIndex))
          //cut off the url at the end of string
          if let newestIndex = (afterLyrics.range(of: "url")?.lowerBound) {
            let cleanLyrics = String(afterLyrics.substring(to: newestIndex))
            lyrics = cleanLyrics
          }
        }
      }
      //if lyrics is still an empty string, the parsing failed so I'll display an error
      if lyrics == "" {
        completion(lyrics)
      } else {
        //remove new line and escaping characters
        let noNewLines = lyrics.replacingOccurrences(of: "\\n", with: ", ")
        let noSlashes = noNewLines.replacingOccurrences(of: "\\", with: "")
        completion(noSlashes)
      }
    })
    
  }

  
  
  
  
}
