// The 'test_digital_assets_11_14' test program.
import digital_assets_11_14.aleo;
program test_digital_assets_11_14.aleo {
    @test
    script test_it() {
        let result: u32 = digital_assets_11_14.aleo/main(1u32, 2u32);
        assert_eq(result, 3u32);
    }

    @test
    @should_fail
    transition do_nothing() {
        let result: u32 = digital_assets_11_14.aleo/main(2u32, 3u32);
        assert_eq(result, 3u32);
    }
}
