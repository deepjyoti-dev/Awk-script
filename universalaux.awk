BEGIN {
    sent = 0;
    received = 0;
    dropped = 0;
    first_packet_time = -1;
    last_packet_time = 0;
    total_delay = 0;
    recv_count = 0;
    bytes_received = 0;
    FS = " ";
}

# Packet sent at AGT layer
$1 == "s" && $4 == "AGT" {
    key = $6 "-" $7; # flow identifier
    send_time[key] = $2;
    sent++;
    if (first_packet_time == -1 || $2 < first_packet_time) {
        first_packet_time = $2;
    }
}

# Packet received at AGT layer
$1 == "r" && $4 == "AGT" {
    key = $6 "-" $7;
    if (key in send_time) {
        delay = $2 - send_time[key];
        total_delay += delay;
        recv_count++;
    }
    received++;
    bytes_received += $10;
    if ($2 > last_packet_time) {
        last_packet_time = $2;
    }
}

# Packet dropped at RTR or IFQ layer
$1 == "d" && ($4 == "RTR" || $4 == "IFQ") {
    dropped++;
}

END {
    print "=========== NS2 Simulation Analysis ===========";
    print "Total Packets Sent        : " sent;
    print "Total Packets Received    : " received;
    print "Total Packets Dropped     : " dropped;

    if (sent > 0) {
        pdr = (received / sent) * 100;
        loss = 100 - pdr;
        print "Packet Delivery Ratio (%) : " pdr;
        print "Packet Loss Ratio (%)     : " loss;
    }

    if (recv_count > 0) {
        avg_delay = total_delay / recv_count;
        print "Average End-to-End Delay  : " avg_delay " sec";
    }

    duration = last_packet_time - first_packet_time;
    if (duration > 0) {
        throughput = (bytes_received * 8) / (duration * 1000); # kbps
        print "Throughput (kbps)         : " throughput;
    }

    print "Simulation Duration       : " duration " sec";
    print "===============================================";
}
