# advanced-encryption-standard

## Project Description

- 본 프로젝트는 Altera FPGA와 NIOS II 시스템을 이용, System Verilog(Hardware Description Language)와 C++를 사용하여 하드웨어와 소프트웨어를 연결하여 AES(Advanced Encryption Standard) 암호화 및 복호화를 구현해내는 프로젝트입니다. 
- 메시지가 FPGA를 통해 입력이 되면 C++를 이용하여 설계된 NIOS II 시스템 내에서 전달받은 메시지를 암호화하여 다시 암호화 된 값을 FPGA 칩셋으로 전송하여 디스플레이에 암호화 된 문자를 볼 수 있게 하며, 이 때 호스트 간의 데이터 전송을 위해 System Verilog를 이용하여 데이터 파이프라인을 설계합니다. 이 후 암호화 된 문자를 다시 복호화 하기 위해서도 매우 유사한 프로토콜을 진행하게 되는데, 다만 암호화에 사용되었던 알고리즘과 다소 반대되는 알고리즘을 사용하여 복호화를 하게 됩니다.
- 이 프로젝트는 또한, 단순한 데이터 전송이 아닌 암호화 및 복호화를 단계적으로 진행하고 하드웨어 언어의 특성상 데이터가 유실되지 않고 전송되는 데에 다소 시간이 필요하기 때문에, state machine을 구현합니다. State machine에 대한 state diagram은 AES LAB 문서 하단에 기재되어 있습니다.

## Reference

- [ECE385 AES LAB.docx](https://github.com/FlexEasy/advanced-encryption-standard/files/7721013/ECE385.AES.LAB.docx)

