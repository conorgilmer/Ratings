       IDENTIFICATION DIVISION.
       PROGRAM-ID. CHESSRATING.
       AUTHOR. Conor Gilmer.
       DATE-WRITTEN.  March 1997.
       DATE-COMPILED. April 1997.
       
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-PC.
       OBJECT-COMPUTER. IBM-PC.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT games-file ASSIGN TO "GAMES.DAT"
                  ORGANIZATION IS LINE SEQUENTIAL.
           SELECT season-file  ASSIGN TO "SEASON.DAT"
                  ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD games-file.
       01 games-record              PIC X(65).
       
       FD season-file.
       01 season-record             PIC X(80).
 
       WORKING-STORAGE SECTION.
       01 switches.
          03 ws-player-eof          PIC X    VALUE "N".
          03 ws-games-eof           PIC X    VALUE "N".
          03 ws-season-eof          PIC X    VALUE "N".
          03 ws-print-details       PIC X    VALUE "N".
      
       01 ws-games.
          03 ws-game-no             PIC 99.
          03 ws-game-competition    PIC X(15).
          03 ws-game-venue          PIC X.
          03 ws-game-result         PIC X.
          03 ws-game-colour         PIC X.
          03 ws-game-opp-rating     PIC 9999.
          03 ws-game-opp-name       PIC X(20).
          03 ws-game-opp-club       PIC X(20).
       
       01 ws-player.
          03 ws-player-name         PIC X(20).
          03 ws-player-rating       PIC 9999.
          03 ws-player-new-rating   PIC 9999.
          03 ws-player-club         PIC X(20).
          03 ws-rating-diff         PIC S9999  VALUE ZEROS.
          03 ws-rating-change       PIC S9999  VALUE ZEROS.

       01 ws-overall.
          03 ws-overall-change      PIC S9999  VALUE ZEROS.
 
       01 ws-report-record.
          03                        PIC X(3)  VALUE SPACES.
          03 ws-opp-rating          PIC 9(4).
          03                        PIC X(3)   VALUE SPACES.
          03 ws-your-rating         PIC 9(4).
          03                        PIC X(3)   VALUE SPACES.
          03 ws-rating1-diff        PIC +ZZZ9.
          03                        PIC X(3)   VALUE SPACES.
          03 ws-rating1-change      PIC +ZZZ9.
          03                        PIC X(3)   VALUE SPACES.
          03 ws-report-result       PIC X(5).

       01 ws-blank-line             PIC X(80)  VALUE SPACES.
       01 ws-lines-line             PIC X(80)  VALUE ALL '-'.

       01 counters.
          03 rec-counter            PIC 999    VALUE ZEROS.

       PROCEDURE DIVISION.
       BEGIN.
       000-MAIN. 
            DISPLAY "Chess Rating Program"
            PERFORM 100-GET-PLAYER-INFO
            PERFORM 200-INITIALIZE
            MOVE "N" TO ws-print-details
            PERFORM 300-PROCESS-GAMES
                   UNTIL ws-games-eof = "Y"
            PERFORM 500-CLOSE
            DISPLAY rec-counter " games processed for " ws-player-name 
                " overall change " ws-overall-change
            DISPLAY "End of Chess Rating Program"
            STOP RUN.

      * Setting players information for now
       100-GET-PLAYER-INFO.
            move "Joe Bloggs" to ws-player-name
            move 1500 to ws-player-rating
            move "My Club" to ws-player-club.

       200-INITIALIZE.
            DISPLAY "INITALIZING"
            OPEN INPUT  games-file

            READ games-file INTO ws-games
                 AT END
                     MOVE "Y" TO ws-games-eof
                 NOT AT END
                     COMPUTE rec-counter = rec-counter + 1
            END-READ
            OPEN OUTPUT season-file.

       300-PROCESS-GAMES.

            IF ws-print-details = "Y"
                PERFORM 400-PRINT-MATCH-DETAILS
            END-IF

            MOVE ws-game-opp-rating TO ws-opp-rating
            MOVE ws-player-rating   TO ws-your-rating
            COMPUTE ws-rating-diff = ws-opp-rating - ws-player-rating
            MOVE ws-rating-diff TO ws-rating1-diff

            IF ws-game-result = "W"
                 MOVE "Win" to ws-report-result
                 COMPUTE ws-rating-change =  16 + (ws-rating-diff/100)*4
                 IF ws-rating-change < 0
                      MOVE 0 TO ws-rating-change
                 END-IF
            END-IF
                  
            IF ws-game-result = "D"
                 MOVE "Draw" to ws-report-result
                 COMPUTE ws-rating-change = (ws-rating-diff/100) * 4
            END-IF
                  
            IF ws-game-result = "L"
                 MOVE "Loss" to ws-report-result
                 COMPUTE ws-rating-change = -16 + (ws-rating-diff/100)*4
                 IF ws-rating-change > 0
                      MOVE 0 TO ws-rating-change
                 END-IF
            END-IF
            MOVE ws-rating-change TO ws-rating1-change

            COMPUTE ws-overall-change = 
                 ws-overall-change + ws-rating-change
                  
            DISPLAY ws-report-record

            WRITE season-record FROM ws-report-record

            READ games-file INTO ws-games
                 AT END
                     MOVE "Y" TO ws-games-eof
                 NOT AT END
                     COMPUTE rec-counter = rec-counter + 1
            END-READ.

       400-PRINT-MATCH-DETAILS.
            DISPLAY "Game        >>> " ws-game-no
            DISPLAY "Competition >>> " ws-game-competition
            DISPLAY "Venue       >>> " ws-game-venue
            DISPLAY "Result      >>> " ws-game-result
            DISPLAY "Colour      >>> " ws-game-colour
            DISPLAY "Rating      >>> " ws-game-opp-rating
            DISPLAY "Opponent    >>> " ws-game-opp-name
            DISPLAY "Club        >>> " ws-game-opp-club.

       500-CLOSE.
            DISPLAY "Closing Files"
            CLOSE games-file
            CLOSE season-file.
