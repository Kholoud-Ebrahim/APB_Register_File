#***************************************************#
# Clean Work Library
#***************************************************#
if [file exists "work"] {vdel -all}
vlib work

#***************************************************#
# Start a new Transcript File
#***************************************************#
#transcript file log/apb_rf.log
# better make one for each test

#***************************************************#
# Compile RTL and TB files
#***************************************************#
vlog -f rf_dut.f
vlog -f rf_tb.f

#***************************************************#
# Optimizing Design with vopt
#***************************************************#
vopt top -o top_opt -debugdb  +acc +cover=sbecf+apb_register_file(rtl).

#***************************************************#
# Simulation of a Test
#***************************************************#
#********************************** 1. READ STAT REG TEST ***********************************#
transcript file log/stat_test_log.log
vsim top_opt -c -assertdebug -debugDB -fsmdebug -coverage +UVM_TESTNAME=rf_r_stat_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage attribute -name TESTNAME -value stat_test
coverage save coverage/stat_test.ucdb

#********************************** 2. WRITE READ CTL REG TEST ***********************************#
transcript file log/ctl_test_log.log
vsim top_opt -c -assertdebug -debugDB -fsmdebug -coverage +UVM_TESTNAME=rf_wr_ctl_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage attribute -name TESTNAME -value ctl_test
coverage save coverage/ctl_test.ucdb

#********************************** 3. WRITE READ TIMER0 REG TEST ***********************************#
transcript file log/timero_test_log.log
vsim top_opt -c -assertdebug -debugDB -fsmdebug -coverage +UVM_TESTNAME=rf_wr_to_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage attribute -name TESTNAME -value timero_test
coverage save coverage/timero_test.ucdb

#********************************** 4. WRITE READ TIMER1 REG TEST ***********************************#
transcript file log/timer1_test_log.log
vsim top_opt -c -assertdebug -debugDB -fsmdebug -coverage +UVM_TESTNAME=rf_wr_t1_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage attribute -name TESTNAME -value timer1_test
coverage save coverage/timer1_test.ucdb

#***************************************************#
# Close the Transcript file
#***************************************************#
transcript file ()

#***************************************************#
# save the coverage in text files
#***************************************************#
vcover merge  coverage/test_all.ucdb \
              coverage/stat_test.ucdb \
              coverage/ctl_test.ucdb \
              coverage/timero_test.ucdb \
              coverage/timer1_test.ucdb

#vcover report coverage/test_all.ucdb -cvg -details -output coverage/fun_coverage.txt
vcover report coverage/test_all.ucdb  -output coverage/code_coverage.txt
#vcover report coverage/test_all.ucdb -details -assert  -output coverage/assertions.txt
