// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import "./MultiOwnableTestBase.t.sol";

contract RemoveOwnerAtIndexTest is MultiOwnableTestBase {
    function testRemovesOwner() public {
        vm.prank(owner1Address);
        _removeOwner();
        assertFalse(mock.isOwner(owner2Bytes));
    }

    function testRemovesOwnerAtIndex() public {
        uint8 index = _index();
        vm.prank(owner1Address);
        _removeOwner();
        assertEq(mock.ownerAtIndex(index), hex"");
    }

    function testEmitsRemoveOwner() public {
        vm.expectEmit(true, true, true, false);
        emit MultiOwnable.RemoveOwner(owner2Bytes, owner1Bytes, _index());
        vm.prank(owner1Address);
        _removeOwner();
    }

    function testRevertsIfCalledByNonOwner() public {
        vm.startPrank(address(0xdead));
        vm.expectRevert(MultiOwnable.Unauthorized.selector);
        _removeOwner();
    }

    function _removeOwner() internal virtual {
        mock.removeOwnerAtIndex(_index());
    }

    function _index() internal virtual returns (uint8) {
        return 1;
    }
}