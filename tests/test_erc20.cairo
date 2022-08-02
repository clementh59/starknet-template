%lang starknet
from contracts.interfaces.IERC20 import IERC20
from starkware.cairo.common.cairo_builtins import HashBuiltin
from tests.constants import (
    ADMIN
)
from tests.deployer import (test_integration, DeployedContracts)
from starkware.cairo.common.uint256 import Uint256

@external
func __setup__{syscall_ptr : felt*, range_check_ptr, pedersen_ptr : HashBuiltin*}():
    let (deployed_contracts : DeployedContracts) = test_integration.deploy_contracts()
    let erc20_address = deployed_contracts.erc20_address
    let main_address = deployed_contracts.main_address

    %{ context.erc20_address = ids.erc20_address %}
    %{ context.main_address = ids.main_address %}
    return ()
end

@view
func test_balance{syscall_ptr : felt*, range_check_ptr, pedersen_ptr : HashBuiltin*}():
    let (deployed_contracts : DeployedContracts) = test_integration.get_deployed_contracts_from_context()
    let (balance) = IERC20.balanceOf(deployed_contracts.erc20_address, ADMIN)
    
    assert Uint256(1000000000, 0) = balance

    return ()
end
