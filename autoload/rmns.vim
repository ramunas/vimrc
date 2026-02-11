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
    execute "bwipeout" currBuf
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


