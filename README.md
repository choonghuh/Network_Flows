# Network_Flows
# by Choong Huh
# Washington State University - Vancouver

The attached Shell script is a homework assignment from WSU-V's networking curiculum. Student is provided a CSV-format list of WireShark-captured ~800,000 events of packet flows that took place on the WSU-V server for a period of time. The script does the following: 

1. The script calculates the average packet size. The size in bytes is awk-parsed and divided by the total number of packets.

2.1 and 2.2 A new CSV file is created that contains the duration of each flows. The cumulative distribution plot is generated linearly and logarithmically via gnuplot and can be found in the attached PDF document. Part [2.2] generates plots of flow sizes.

Part 2.3 summarizes the flows by sorting them by top 10 most frequent source ports and receiver ports. The screenshot of the output can be found in the attached PDF document.

2.4 Traffic volumes are grouped together by their ip-mask. The commented portion of 2.4 is due to the usage of system call and ipcalc that consume up to 40 minutes per execution. 
[ipcalc - http://jodies.de/ipcalc]

2.5 Program searches through flows that left or came to the WSU-V using the server's ip-mask and reports the percentage of WSU-V related traffic among all flows, in terms of both of the flow durations and the volume.
