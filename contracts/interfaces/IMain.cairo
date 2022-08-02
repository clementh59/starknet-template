%lang starknet

from starkware.cairo.common.uint256 import Uint256

@contract_interface
namespace IMain:
    func increase_balance(amount : felt):
    end

    func get_balance() -> (res : felt):
    end
end