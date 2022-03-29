       01  WS-:TAG:-REC.
           05  :TAG:-PATIENT-NBR             PIC 9(5).
           05  :TAG:-PATIENT-NAME.
               10 :TAG:-LAST-NAME            PIC X(22).
               10 :TAG:-FIRST-NAME           PIC X(22).
           05  :TAG:-PATIENT-PHONE           PIC X(10).
           05  :TAG:-PATIENT-TYPE            PIC X(1).
               88 :TAG:-INPATIENT   VALUE "I".
               88 :TAG:-OUTPATIENT  VALUE "0".
               88 :TAG:-VALID-TYPE  VALUES ARE "I", "O".
           05  :TAG:-BED-IDENTITY            PIC 9(4).
           05  :TAG:-DATE-ADMIT              PIC X(10).
           05  :TAG:-AMT-PER-DAY             PIC 9(5)V99.
           05  :TAG:-INS-TYPE                PIC X(3).
               88 :TAG:-VALID-INS VALUES ARE "HMO", "PPO", "POS" "MAN".
               88 :TAG:-MANAGED-CARE VALUE "MAN".
           05  :TAG:-COPAY                   PIC S9(3).
           05  :TAG:-DEDUCTIBLE              PIC S9(4).
           05  :TAG:-PATIENT-TOT-AMT         PIC 9(7)V99.