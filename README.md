📊 Performance Analysis

This project includes an AWK-based trace analyzer for evaluating network performance metrics from NS2 trace files.

Metrics calculated:

Packet Delivery Ratio (PDR)
Packet Loss Ratio
Throughput
Average End-to-End Delay
Total Packets Sent
Total Packets Received
Packet Drops
▶️ Run Analysis
awk -f analysis/performance_analysis.awk out.tr
Example Output
=========== NS2 Simulation Analysis ===========
Total Packets Sent        : 120
Total Packets Received    : 115
Total Packets Dropped     : 5
Packet Delivery Ratio (%) : 95.8333
Packet Loss Ratio (%)     : 4.1667
Average End-to-End Delay  : 0.024 sec
Throughput (kbps)         : 410.24
Simulation Duration       : 4.5 sec
===============================================
