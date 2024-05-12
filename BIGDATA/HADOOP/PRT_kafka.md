4) Take a scenario of you uploading a file of 700MB into HDFS.300MB of data is successfully uploaded into HDFS and another client wants to read the uploaded data while the upload is still in progress. What will happen in such a scenario, will the 300 MB of data that is uploaded will be displayed? Explain with proper details.

In the scenario you described, whether the 300MB of uploaded data is visible to the other client depends on a few factors:
HDFS Block Size:
HDFS breaks down files into blocks for storage across the DataNodes. The default block size can vary depending on the HDFS version (typically 64MB in HDFS 1.x and 128MB in HDFS 2.x).
Data Upload Progress:
Let's consider a block size of 128MB for this example.
If the first two blocks (256MB) of your 700MB file have been uploaded completely, those blocks are finalized and reported to the NameNode (HDFS directory manager).
The NameNode keeps track of finalized blocks and their locations.
Client Reading Behavior:
When the other client tries to read the file, it communicates with the NameNode.
The NameNode will provide information only about finalized blocks.
Visibility of Uploaded Data:
In this scenario, since the first two blocks (256MB) are finalized, the other client will be able to read those 256MB.
The remaining 44MB (partially uploaded third block) will not be visible. HDFS ensures data consistency and avoids serving incomplete data blocks.

Summary:
The uploading client can control data visibility to some extent by managing how much data gets uploaded before the upload process is complete.
HDFS ensures data consistency by only serving finalized blocks. This might lead to a temporary inconsistency between the uploaded data amount and what's visible to other clients during an upload.

