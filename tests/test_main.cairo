%lang starknet
from contracts.interfaces.IMain import IMain
from starkware.cairo.common.cairo_builtins import HashBuiltin
from tests.constants import (
    ADMIN
)
from tests.deployer import (test_integration, DeployedContracts)

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
func test_increase_balance{syscall_ptr : felt*, range_check_ptr, pedersen_ptr : HashBuiltin*}():
    let (deployed_contracts : DeployedContracts) = test_integration.get_deployed_contracts_from_context()
    let (result_before) = IMain.get_balance(contract_address=deployed_contracts.main_address)
    assert result_before = 0

    IMain.increase_balance(deployed_contracts.main_address, 42)

    let (result_after) = IMain.get_balance(deployed_contracts.main_address)
    assert result_after = 42
    return ()
end

@view
func test_cannot_increase_balance_with_negative_value{
    syscall_ptr : felt*, range_check_ptr, pedersen_ptr : HashBuiltin*
}():
    let (deployed_contracts : DeployedContracts) = test_integration.get_deployed_contracts_from_context()
    let (result_before) = IMain.get_balance(contract_address=deployed_contracts.main_address)
    assert result_before = 0

    %{ expect_revert("TRANSACTION_FAILED", "Amount must be positive") %}
    IMain.increase_balance(deployed_contracts.main_address, -42)

    return ()
end