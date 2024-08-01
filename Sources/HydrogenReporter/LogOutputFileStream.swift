import Foundation

// MARK: Logger text output for using print
public struct LogOutputFileStream: TextOutputStream {
    var logFile: URL
    
    init(logFile: URL) {
        self.logFile = logFile
    }
    
    public mutating func write(_ string: String) {
        if let handle = try? FileHandle(forWritingTo: logFile) {
            handle.seekToEndOfFile()
            handle.write(string.data(using: .utf8) ?? Data())
            handle.closeFile()
        } else {
            try? string.data(using: .utf8)?.write(to: logFile)
        }
    }
}
