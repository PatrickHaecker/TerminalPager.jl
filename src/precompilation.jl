# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Description
# ==========================================================================================
#
#   Precompilation.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

import PrecompileTools

PrecompileTools.@setup_workload begin
    # We will redirect the `stdout` and `stdin` so that we can execute the pager and input
    # some commands without making visible changes to the user.
    old_stdout = Base.stdout
    redirect_stdout()

    stdin_rd, stdin_wr = redirect_stdin()

    PrecompileTools.@compile_workload begin
        a = vcat(fill(0.1986, 100)', rand(100, 100))
        @async pager(a)

        # Ruler.
        write(stdin_wr, "r")
        # Freeze rows and columns.
        write(stdin_wr, "f10\n10\n")
        # Title rows.
        write(stdin_wr, "t1\n")
        # Down.
        write(stdin_wr, "\eOB")
        # Up.
        write(stdin_wr, "\eOA")
        # Right.
        write(stdin_wr, "\eOC")
        # Left.
        write(stdin_wr, "\eOD")
        # Page down.
        write(stdin_wr, "\e[6~")
        # Page up.
        write(stdin_wr, "\e[5~")
        # End.
        write(stdin_wr, "\e[F")
        # Home.
        write(stdin_wr, "\e[H")
        # Visual mode.
        write(stdin_wr, "v")
        # Mark lines.
        write(stdin_wr, "mjmjmjmjmjm")
        # Unmark lines.
        write(stdin_wr, "mkmk")
        # Exit visual mode.
        write(stdin_wr, "v")
        # Help.
        write(stdin_wr, "?")
        # Exit help mode.
        write(stdin_wr, "q")
        # Search.
        write(stdin_wr, "/0.1986\n")
        # Next search.
        write(stdin_wr, "nnn")
        # Exit search (ESC).
        write(stdin_wr, Char(27))
        # Exit pager.
        write(stdin_wr, "q")
    end

    redirect_stdout(old_stdout)
end
