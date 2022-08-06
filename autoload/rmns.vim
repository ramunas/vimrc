vim9script

# Delete a current buffer without closing the current window. But, instead,
# switching either to an alternative, or if one is not available the some other
# buffer.
export def DeleteBuffer2()
    var currBuf = bufnr()

    var bufs = getbufinfo({'buflisted': 1})
    if len(bufs) == 1
        enew
        bufs = getbufinfo({'buflisted': 1})
    endif

    # enew is not guaranteed to create a buffer. Then, there's nothing to be
    # done.
    if len(bufs) == 1
        return
    endif

    var nextBuf = bufnr("#")
    if nextBuf == currBuf
        nextBuf = -1
    endif

    # if buffer does not have an alternative buffer
    # then pick some buffer
    if nextBuf < 0
        for buf in bufs
            if buf["bufnr"] != currBuf
                nextBuf = buf["bufnr"]
                break
            endif
        endfor
    endif

    execute "buffer" nextBuf
    execute "bdelete" currBuf
enddef


export def ShowGnuInfoDocPage(page: string)
    new
    execute ':%!info' page
    syntax match Identifier |^\* .*:|
    syntax match Identifier |^\d.*$|
    syntax match Identifier |^=\+$|
    syntax match Identifier |^*\+$|
    setlocal nobuflisted nomodified buftype=nofile bufhidden=wipe readonly
    map <buffer> q :q<cr>
enddef


def GetVisibleTerminalBufNr(): number
    for x in term_list()
        var wid = bufwinid(x)
        if wid > 0
            return x
        endif
    endfor
    return -1
enddef

export def SendBufLinesToTerminalBuffer(lnum1: number, lnum2: number)
    var buf = GetVisibleTerminalBufNr()
    if buf < 0
        echo "No terminal found"
        return
    endif

    # stutter copying to a terminal. Otherwise, the terminal might be too slow
    # at handling the characters, and some may be list and corrupted.
    for l in getline(lnum1, lnum2)
        sleep 1m
        term_sendkeys(buf, l .. "\n")
        redraw
    endfor
enddef

export def FilterBufferCommand(command: string)
    var pos = getcurpos()
    execute ":%!" command
    setpos('.', pos)
enddef
