// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.8.12;

import {TWAMM} from '../libraries/TWAMM.sol';

contract TWAMMTest {
    using TWAMM for TWAMM.State;

    TWAMM.State public twamm;

    function initialize(uint256 orderInterval) external {
        twamm.initialize(orderInterval);
    }

    function submitLongTermOrder(TWAMM.LongTermOrderParams calldata params) external returns (uint256 orderId) {
        orderId = twamm.submitLongTermOrder(params);
    }

    function cancelLongTermOrder(uint256 orderId) external {
        twamm.cancelLongTermOrder(orderId);
    }

    function getOrder(uint256 orderId) external view returns (TWAMM.Order memory) {
        return twamm.orders[orderId];
    }

    function getOrderPool(uint8 index) external view returns (uint256 sellRate, uint256 earningsFactor) {
        TWAMM.OrderPool storage order = twamm.orderPools[index];
        sellRate = order.sellRate;
        earningsFactor = order.earningsFactor;
    }

    function getOrderPoolSellRateEndingPerInterval(uint8 sellTokenIndex, uint256 timestamp)
        external
        view
        returns (uint256 sellRate)
    {
        return twamm.orderPools[sellTokenIndex].sellRateEndingPerInterval[timestamp];
    }

    function getState()
        external
        view
        returns (
            uint256 expirationInterval,
            uint256 lastVirtualOrderTimestamp,
            uint256 nextId
        )
    {
        expirationInterval = twamm.expirationInterval;
        lastVirtualOrderTimestamp = twamm.lastVirtualOrderTimestamp;
        nextId = twamm.nextId;
    }

    function getNextId() external view returns (uint256 nextId) {
        return twamm.nextId;
    }
}