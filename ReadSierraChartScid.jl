# this program reads data from a local C:/SierraChart/data directory
# it only reads files which start with ESmyy and have a .scid extension
# these are native binary Sierra Chart data files
# m is a futures contract month code: H, M, U, or Z
# yy is a 2 digit year

# the following struct definitions are taken from the Sierra Chart scdatetime.h file
# Times are in UTC
struct SCDateTime
    int64_t::m_dt  # microseconds
end

# the following  struct definitions are taken from the Sierra Chart IntradayRecord.h file

struct s_IntradayFileHeader
    unsigned(int32)::FileTypeUniqueHeaderID
	unsigned(int32)::HeaderSize;
	unsigned(int32)::RecordSize;
	unsigned(int16)::Version;
	unsigned(int16)::Unused1;
	unsigned(int32)::Unused2;
	char::Reserve[36];
end

struct s_IntradayRecord
        SCDateTimeM::DateTime;
    
        float32::Open
        float32::High
        float32::Low
        float32::Close
    
        unsigned(int32)::NumTrades;
        unsigned(int32)::TotalVolume;
        unsigned(int32)::BidVolume;
        unsigned(int32)::AskVolume;
end
