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
	Reserve::Vector{UInt8}

    s_IntradayFileHeader() = new() # allow cretion of uninitialed object
end

function read_hdr(f::IOStream, hdr::s_IntradayFileHeader)
    read(f, hdr.FileTypeUniqueHeaderID)
    read(f, hdr.HeaderSize)
    read(f, hdr.RecordSize)
    read(f, hdr.Version)
    read(f, hdr.Unused1)
    read(f, hdr.Unused2)
    read(f, hdr.Reserve)
end

function write_hdr(f::IOStream, hdr::s_IntradayFileHeader)
    write(f, hdr.FileTypeUniqueHeaderID)
    write(f, hdr.HeaderSize)
    write(f, hdr.RecordSize)
    write(f, hdr.Version)
    write(f, hdr.Unused1)
    write(f, hdr.Unused2)
    write(f, hdr.Reserve)
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

    my_test = s_IntradayFileHeader(0,0,0,0,0,0,zeros(UInt8,36))
    my_test.Reserve[1] = 'a'
    a = 7
end

function processScidFile(futures_root:Char, filename::String, datafile_outdir::String)
    # 3rd char of file name is futures code: H, M, U, or Z
    futures_code = uppercase(filename[3])
    if !(futures_code in ['H', 'M', 'U', 'Z'])
        return
    end
end

main()
