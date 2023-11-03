# APB Register File

| Signal    | Direction| Width|
|-----------|----------|------|
| pclk      | input    |  1   |
| presetn   | input    |  1   |
| paddr     | input    | SIZE |
| pwdata    | input    | SIZE |
| psel      | input    |  1   |
| pwrite    | input    |  1   |
| penable   | input    |  1   |
| prdata    | output   | SIZE |

## The Registers in the APB RF
|   name    |                          Description                                                              | Address| Width|
|-----------|---------------------------------------------------------------------------------------------------|--------|------|
| ctl_reg   | Contains fields to start the module, and configure it to be in the blink yellow or blink red mode.|   0x0  |   4  |
| timer_0   | Stores the time between transition from each state.                                               |   0x4  |  32  |
| timer_1   | Stores the time between transition from each state.                                               |   0x8  |  32  |
| stat_reg  | Returns current state of the design yellow, red or green; read-only register.                     |   0xC  |   2  |

![image](https://github.com/UserImages/user_images/blob/main/apb_rf.PNG)

