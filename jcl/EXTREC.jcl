//CONVRECZ JOB ,
// MSGCLASS=H,MSGLEVEL=(1,1),TIME=(,4),REGION=144M,COND=(16,LT)
//***************************************************************
//* JOB TO EXTRACT A RECORDED PLAYBACK FILE IN JSON FORMAT
//***************************************************************
// SET DSNSRC=EMANUP.BZU.VTP.PLAYBACK
// SET DSNPLBC=EMANUP.VTP.DEMO.PLAYBACK
//***************************************************************
//* TESTCASE NAME
//***************************************************************
// SET TESTNAME=GENAPP1 <-- Modify
//***************************************************************
//* DELETE THE DESTINATION FILE AND DATASET IF EXIST
//***************************************************************
//STEP001 EXEC PGM=IEFBR14
//BZUPLBC DD DSN=&DSNPLBC..&TESTNAME,
//           DISP=(MOD,DELETE,DELETE),SPACE=(TRK,1)
//BZUJSON DD PATH='/u/emanup/&TESTNAME..vtptc',
//           PATHDISP=(DELETE,DELETE),
//           PATHOPTS=(OCREAT,ORDWR),
//           PATHMODE=(SIRUSR,SIWUSR)
//***************************************************************
//* COPY THE RECORDED PLAYBACK FILE TO A PERMANENT DATASET
//***************************************************************
//CPYPLBCK EXEC PGM=IEBGENER
//SYSPRINT DD SYSOUT=*
//SYSIN DD DUMMY
//SYSUT1 DD DSN=&DSNSRC,DISP=SHR
//SYSUT2 DD DSN=&DSNPLBC..&TESTNAME,DISP=(NEW,CATLG),
//          SPACE=(CYL,(1,7)),
//          BLKSIZE=32256,
//          RECFM=FB,
//          LRECL=512,
//          UNIT=SYSALLDA,
//          DSNTYPE=BASIC
//***************************************************************
//* COPY THE METADATA
//***************************************************************
//CPYMETA EXEC PGM=BZUPLAY,
// PARM='RUN=BZUMETA,SEARCH=&DSNPLBC..&TESTNAME'
//STEPLIB DD DISP=SHR,DSN=RDZ.V15.SBZULOAD
//BZUMETA DD DSN=&&DSNMETA,
//           DISP=(NEW,CATLG),SPACE=(TRK,(100,50)),
//           UNIT=SYSDA,DCB=(BLKSIZE=8196,LRECL=8192,RECFM=VB)
//***************************************************************
//* COPY THE JSON
//***************************************************************
//CPYJSON EXEC PGM=BZUPLAY,
// PARM='RUN=BZUTCP'
//STEPLIB DD DISP=SHR,DSN=RDZ.V15.SBZULOAD
//BZUMETA DD DISP=SHR,DSN=&&DSNMETA
//BZUJSON DD PATH='/u/emanup/&TESTNAME..vtptc',
//           PATHDISP=(KEEP,DELETE),
//           PATHOPTS=(OCREAT,ORDWR),
//           PATHMODE=(SIRUSR,SIWUSR),
//           FILEDATA=TEXT
//BZUMSG  DD SYSOUT=*