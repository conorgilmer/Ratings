       IDENTIFICATION DIVISION.
       PROGRAM-ID. CHESSSCORECARD.
       AUTHOR. Conor Gilmer.
       DATE-WRITTEN.  March 1997.
       DATE-COMPILED. April 1997.
       
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-PC.
       OBJECT-COMPUTER. IBM-PC.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT teams-file ASSIGN TO "MATCH-IN.DAT"
                  ORGANIZATION IS LINE SEQUENTIAL.
           SELECT scorecard-file  ASSIGN TO "SCORECARD.DAT"
                  ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD teams-file.
       01 teams-record              PIC X(62).
       
       FD scorecard-file.
       01 scorecard-record          PIC X(80).
 
       WORKING-STORAGE SECTION.
       01 switches.
          03 ws-in-eof              PIC X    VALUE "N".
      
       01 ws-in-record.
          03 ws-in-game-number      PIC 9(2).
          03 ws-in-home-player      PIC 9(20).
          03 ws-in-home-rating      PIC 9(4).
          03 ws-in-home-icu-code    PIC 9(6).
          03 ws-in-away-player      PIC 9(20).
          03 ws-in-away-rating      PIC 9(4).
          03 ws-in-away-icu-code    PIC 9(6).

       01 ws-report-record.
          03                        PIC X(3)  VALUE SPACES.
          03 ws-game-number         PIC 9(2).
          03                        PIC X     VALUE SPACES.
          03 ws-home-player         PIC 9(20).
          03                        PIC X     VALUE SPACES.
          03 ws-home-rating         PIC 9(4).
          03                        PIC X     VALUE SPACES.
          03 ws-home-icu-code       PIC 9(6).
          03                        PIC X     VALUE SPACES.
          03 ws-home-points         PIC 9v9.
          03                        PIC X     VALUE SPACES.
          03 ws-away-player         PIC 9(20).
          03                        PIC X     VALUE SPACES.
          03 ws-away-rating         PIC 9(4).
          03                        PIC X     VALUE SPACES.
          03 ws-away-icu-code       PIC 9(6).
          03                        PIC X     VALUE SPACES.
          03 ws-away-points         PIC 9v9.

       01 ws-report-total-record.
          03                        PIC X(35)  VALUE SPACES.
          03 ws-home-total          PIC 9v9    VALUE ZEROS.
          03                        PIC X(35)  VALUE SPACES.
          03 ws-away-total          PIC 9v9    VALUE ZEROS.

       01 ws-blank-line             PIC X(70)  VALUE SPACES.
       01 ws-lines-line             PIC X(70)  VALUE ALL '-'.

       01 ws-results.
          03 ws-game-result         PIC X.
   

       01 counters.
          03 rec-counter            PIC 999    VALUE ZEROS.

       PROCEDURE DIVISION.
       000-MAIN. 
            DISPLAY "Chess Scorecard Program"
            PERFORM 200-INITIALIZE
            PERFORM 300-PROCESS-GAMES
                   UNTIL ws-in-eof = "Y"
            WRITE scorecard-record   FROM ws-report-total-record
            PERFORM 500-CLOSE
            DISPLAY rec-counter " games processed"
            DISPLAY "End of Chess Rating Program"
            STOP RUN.

       200-INITIALIZE.
            DISPLAY "INITALIZING"
            OPEN INPUT  teams-file

            READ teams-file INTO ws-in-record
                 AT END
                     MOVE "Y" TO ws-in-eof
                 NOT AT END
                     COMPUTE rec-counter = rec-counter + 1
            END-READ
            OPEN OUTPUT scorecard-file.

       300-PROCESS-GAMES.

            MOVE ws-in-game-number   to ws-game-number
            MOVE ws-in-home-player   to ws-home-player
            MOVE ws-in-home-rating   to ws-home-rating
            MOVE ws-in-home-icu-code to ws-away-icu-code
            MOVE ws-in-away-player   to ws-away-player
            MOVE ws-in-away-rating   to ws-away-rating
            MOVE ws-in-away-icu-code to ws-away-icu-code

            PERFORM 400-GET-RESULT
                  
            DISPLAY ws-report-record

            WRITE scorecard-record   FROM ws-report-record

            READ teams-file INTO ws-in-record
                 AT END
                     MOVE "Y" TO ws-in-eof
                 NOT AT END
                     COMPUTE rec-counter = rec-counter + 1
            END-READ.

       400-GET-RESULT.
           DISPLAY "Enter the Result for Game (Home Win 0, Draw = "
                   " Home Loss 0  ) for game " rec-counter 
           ACCEPT ws-game-result 
           IF ws-game-result = "1"
              MOVE 1 to ws-home-points
              MOVE 0 to ws-away-points
           END-IF
           IF ws-game-result = "0"
              MOVE 0 to ws-home-points
              MOVE 1 to ws-away-points
           END-IF
           IF ws-game-result = "="
              MOVE 0.5 to ws-home-points
              MOVE 0.5 to ws-away-points
           END-IF


           COMPUTE ws-home-total = ws-home-total + ws-home-points
           COMPUTE ws-away-total = ws-away-total + ws-away-points.
         

       500-CLOSE.
            CLOSE teams-file
            CLOSE scorecard-file.
