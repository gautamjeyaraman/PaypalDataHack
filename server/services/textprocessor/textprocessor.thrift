struct DateTime {
    1: i16 Year,
    2: i16 Month,
    3: i16 Day,
    4: i16 Hour = 0,
    5: i16 Minute = 0
}

struct TimeValues {
    1: string sentence
}

service TextProcessor {
    i16 infer_sentimentType(1:string DocText) 
}
