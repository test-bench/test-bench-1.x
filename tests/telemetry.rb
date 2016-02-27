require_relative './test_init'

context "Telemetry" do
  test "Record that a file was executed" do
    telemetry = TestBench::Telemetry.build

    telemetry.file_executed 'some/file.rb'

    assert telemetry.files.include? 'some/file.rb'
  end

  test "Record that a test passed" do
    telemetry = TestBench::Telemetry.build

    telemetry.test_passed

    assert telemetry.passes == 1
  end

  test "Record that a test failed" do
    telemetry = TestBench::Telemetry.build

    telemetry.test_failed

    assert telemetry.failures == 1
  end

  test "Record that an error was raised" do
    telemetry = TestBench::Telemetry.build

    telemetry.error_raised

    assert telemetry.errors == 1
  end

  test "Record that a test was skipped" do
    telemetry = TestBench::Telemetry.build

    telemetry.test_skipped

    assert telemetry.skips == 1
  end

  test "Record that an assertion was made" do
    telemetry = TestBench::Telemetry.build

    telemetry.asserted

    assert telemetry.assertions == 1
  end

  test "Calculating total number of tests" do
    telemetry = TestBench::Telemetry.new

    telemetry.failures = 1
    telemetry.passes = 2
    telemetry.skips = 3

    assert telemetry.tests == 6
  end

  test "Calculating elapsed time" do
    t0 = Controls::Clock::Elapsed.t0
    t1 = Controls::Clock::Elapsed.t1
    elapsed_time = Controls::Clock::Elapsed.seconds

    telemetry = TestBench::Telemetry.build

    telemetry.start_time = t0
    telemetry.stop_time = t1

    assert telemetry.elapsed_time == elapsed_time
  end

  context "Pass/fail results" do
    passed = Controls::Telemetry::Passed.example
    failed = Controls::Telemetry::Failed.example
    error = Controls::Telemetry::Error.example

    test "Passed" do
      assert passed.passed?
      assert !error.passed?
      assert !failed.passed?
    end

    test "Failed" do
      assert error.failed?
      assert failed.failed?
      assert !passed.failed?
    end
  end
end
