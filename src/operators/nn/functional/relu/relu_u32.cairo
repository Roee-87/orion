use array::ArrayTrait;
use array::SpanTrait;
use option::OptionTrait;

use orion::operators::tensor::core::{Tensor, TensorTrait};
use orion::operators::tensor::implementations::impl_tensor_u32;
use orion::utils::check_gas;

/// Cf: NNTrait::relu docstring
fn relu_u32(z: @Tensor<u32>, threshold:u32 ) -> Tensor<u32> {
    let mut data_result = ArrayTrait::<u32>::new();
    let mut data = *z.data;

    let zero = 0;
    loop {
        check_gas();

        if data.len() == 0 {
            break ();
        };

        let current_index = *data.pop_front().unwrap();
        if current_index < threshold {
            data_result.append(zero);
        } else {
            data_result.append(current_index);
        };
    };

    return TensorTrait::<u32>::new(*z.shape, data_result.span(), *z.extra);
}
