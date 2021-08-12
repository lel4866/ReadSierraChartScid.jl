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
    Reserve1::UInt32
    Reserve2::UInt32
    Reserve3::UInt32
    Reserve4::UInt32
    Reserve5::UInt32
    Reserve6::UInt32
    Reserve7::UInt32
    Reserve8::UInt32
    Reserve9::UInt32
    Reserve10::UInt32
    Reserve11::UInt32
end

function read_hdr(f::IOStream, hdr::s_IntradayFileHeader)
    hdr.FileTypeUniqueHeaderID = read(f, UInt32)
    hdr.HeaderSize = read(f, UInt32)
    hdr.RecordSize = read(f, UInt32)
    hdr.Version = read(f, UInt16)
    hdr.Reserve1 = read(f, UInt16)
    hdr.Reserve2 = read(f, UInt32)
    hdr.Reserve3 = read(f, UInt32)
    hdr.Reserve4 = read(f, UInt32)
    hdr.Reserve5 = read(f, UInt32)
    hdr.Reserve6 = read(f, UInt32)
    hdr.Reserve7 = read(f, UInt32)
    hdr.Reserve8 = read(f, UInt32)
    hdr.Reserve9 = read(f, UInt32)
    hdr.Reserve10 = read(f, UInt32)
    hdr.Reserve11 = read(f, UInt32)
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
    #DateTime::SCDateTime
    DateTime::Int64
    
    Open::Float32
    High::Float32
    Low::Float32
    Close::Float32

    NumTrades::UInt32
    TotalVolume::UInt32
    BidVolume::UInt32
    AskVolume::UInt32

    #s_IntradayRecord() = new(SCDateTime(0)) # allow cretion of uninitialized object
    s_IntradayRecord() = new()
end
function read_rec(f::IOStream, rec::s_IntradayRecord)
    rec.DateTime = read(f, Int64)
    #rec.DateTime.m_dt = read(f, Int64)
    rec.Open = read(f, Float32)
    rec.High = read(f, Float32)
    rec.Low = read(f, Float32)
    rec.Close = read(f, Float32)
    rec.NumTrades = read(f, UInt32)
    rec.TotalVolume = read(f, UInt32)
    rec.BidVolume = read(f, UInt32)
    rec.AskVolume = read(f, UInt32)
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

    my_test1 = s_IntradayFileHeader(1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)
    abc = sizeof(my_test1)
    my_test1.Reserve1 = 5
    my_test2 = s_IntradayRecord()
    bbb = sizeof(my_test2)
    my_test3 = s_IntradayRecord()
    #return my_test1
    

    io = open("C:/SierraChart/Data/ESZ20.scid", "r")
    read_hdr(io, my_test1)
    read_rec(io, my_test2)
    read_rec(io, my_test3)
    xxx = 1 
end

function processScidFile(futures_root::Char, filename::String, datafile_outdir::String)
    # 3rd char of file name is futures code: H, M, U, or Z
    futures_code = uppercase(filename[3])
    if !(futures_code in ['H', 'M', 'U', 'Z'])
        return
    end
end

myt = main()
