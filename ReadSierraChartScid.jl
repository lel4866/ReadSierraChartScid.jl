# this program reads data from a local C:/SierraChart/data directory
# it only reads files which start with ESmyy and have a .scid extension
# these are native binary Sierra Chart data files
# m is a futures contract month code: H, M, U, or Z
# yy is a 2 digit year

# the following struct definitions are taken from the Sierra Chart scdatetime.h file
# Times are in UTC

mutable struct SCDateTime
    m_dt::Int64  # microseconds
end

# the following  struct definitions are taken from the Sierra Chart IntradayRecord.h file

mutable struct s_IntradayFileHeader
    FileTypeUniqueHeaderID::UInt32
	HeaderSize::UInt32
	RecordSize::UInt32
	Version::UInt16
	Unused1::UInt16
	Unused2::UInt32
    # need 36 bytes of reserve - got to be a better way!
    Reserve1::UInt32
    Reserve2::UInt32
    Reserve3::UInt32
    Reserve4::UInt32
    Reserve5::UInt32
    Reserve6::UInt32
    Reserve7::UInt32
    Reserve8::UInt32
    Reserve9::UInt32
end


function read_hdr(f::IOStream, hdr::s_IntradayFileHeader)
    read(f, hdr.FileTypeUniqueHeaderID)
    read(f, hdr.HeaderSize)
    read(f, hdr.RecordSize)
    read(f, hdr.Version)
    read(f, hdr.Unused1)
    read(f, hdr.Unused2)
    read(f, hdr.Reserve1)
    read(f, hdr.Reserve2)
    read(f, hdr.Reserve3)
    read(f, hdr.Reserve4)
    read(f, hdr.Reserve5)
    read(f, hdr.Reserve6)
    read(f, hdr.Reserve7)
    read(f, hdr.Reserve8)
    read(f, hdr.Reserve9)
end

function write_hdr(f::IOStream, hdr::s_IntradayFileHeader)
    write(f, hdr.FileTypeUniqueHeaderID)
    write(f, hdr.HeaderSize)
    write(f, hdr.RecordSize)
    write(f, hdr.Version)
    write(f, hdr.Unused1)
    write(f, hdr.Unused2)
    write(f, hdr.Reserve1)
    write(f, hdr.Reserve2)
    write(f, hdr.Reserve3)
    write(f, hdr.Reserve4)
    write(f, hdr.Reserve5)
    write(f, hdr.Reserve6)
    write(f, hdr.Reserve7)
    write(f, hdr.Reserve8)
    write(f, hdr.Reserve9)
end

mutable struct s_IntradayRecord
    DateTime::SCDateTime
    
    Open::Float32
    High::Float32
    Low::Float32
    Close::Float32

    NumTrades::UInt32
    TotalVolume::UInt32
    BidVolume::UInt32
    AskVolume::UInt32

    s_IntradayRecord() = new() # allow cretion of uninitialed object
end
function read_rec(f::IOStream, rec::s_IntradayRecord)
    read(f, rec.SCDateTime.m_dt)
    read(f, rec.Open)
    read(f, rec.High)
    read(f, rec.Low)
    read(f, rec.Close)
    read(f, rec.NumTrades)
    read(f, rec.TotalVolume)
    read(f, rec.BidVolume)
    read(f, rec.AskVolume)
end

function write_rec(f::IOStream, rec::s_IntradayRecord)
    write(f, rec.SCDateTime.m_dt)
    write(f, rec.Open)
    write(f, rec.High)
    write(f, rec.Low)
    write(f, rec.Close)
    write(f, rec.NumTrades)
    write(f, rec.TotalVolume)
    write(f, rec.BidVolume)
    write(f, rec.AskVolume)
end

function main()
    datafile_dir = "C:/SierraChart/Data/"
    datafile_outdir = "C:/Users/lel48/SierraChartData/" 
    futures_root = "ES" 

    my_test1 = s_IntradayFileHeader(1, 2, 3, 4, 5, 6, [7, 8, 9, 10, 11, 12, 13, 14])
    abc = sizeof(my_test1)
    my_test1.Reserve = ['a', 'b', 'c', 'd']
    def = sizeof(my_test1)
    my_test2 = s_IntradayRecord()
    bbb = sizeof(my_test2)
    #my_test1.R10[1] = 'a'
    return my_test1
end

function processScidFile(futures_root::Char, filename::String, datafile_outdir::String)
    # 3rd char of file name is futures code: H, M, U, or Z
    futures_code = uppercase(filename[3])
    if !(futures_code in ['H', 'M', 'U', 'Z'])
        return
    end
end

myt = main()
