# Block-MOBO
This repository contains Matlab implementation of the algorithm framework for Block-MOBO in the research paper [High-dimensional Multi-objective Bayesian Optimization with Block Coordinate Updates: Case Studies in Intelligent Transportation System](https://ieeexplore.ieee.org/document/10040106) (**Accepted by [IEEE Transactions on Intelligent Transportation Systems 2023](https://ieeexplore.ieee.org/xpl/RecentIssue.jsp?punumber=6979)**).

## Algorithm Preparation
We use [PlatEMO-V2.9.0](https://github.com/BIMK/PlatEMO/releases/tag/PlatEMO_v2.9.0), an evolutionary multi-objective optimization platform, to implement all the related experiments. Details on how to use PlatEMO can be found in [manual.pdf](https://github.com/BIMK/PlatEMO/blob/master/PlatEMO/manual.pdf). Before starting our methods, we recommend to  carefully study how to use the PlatEMO platform.

## Get Started
We recommend runing all the related experiments with GUI of PlatEMO. To invoke the interface, use the function:
```
main()
```
More details can be found in [manual.pdf](https://github.com/BIMK/PlatEMO/blob/master/PlatEMO/manual.pdf). 

## Baselines
The baseline methods in Block-MOBO include random search, NSGA-II [[1]](#nsgaii), SMS-EMOA [[2]](#sms-emoa), ParEGO [[3]](#parego), MOEA/D-EGO [[4]](#moeadego), ReMO [[5]](#remo), Multi-LineBO, K-RVEA [[6]](#krvea) and MOEA/D-ASS [[7]](#moead-ass). ReMO is an optimization architecture that can be equiped with any well known derivative-free MO algorithm. We equip ReMO with ParEGO in this paper to make comparisons with EGO-based methods. Multi-LineBO is a version of single-objective LineBO [[8]](#linebo).

|    Algorithm Name      | Characteristics|    Published     |
| :---------: | :-----------------------------------------------------: | :------------------------------------------------------------------------------------: | 
[NSGA-II](https://ieeexplore.ieee.org/document/996017)| Multi-objective, low-dimensional | IEEE Transactions on Evolutionary Computation 2002 |
[SMS-EMOA](https://www.sciencedirect.com/science/article/pii/S0377221706005443)| Multi-objective, low-dimensional | European Journal of Operational Research 2007 |
[ParEGO](https://www.cs.bham.ac.uk/~jdk/parego/) | Multi-objective, low-dimensional |        IEEE Transactions on Evolutionary Computation 2006         |  
[MOEA/D-EGO](https://ieeexplore.ieee.org/document/5353656) | Multi-objective, low-dimensional |        IEEE Transactions on Evolutionary Computation 2010         | 
[ReMO](https://ojs.aaai.org/index.php/AAAI/article/view/10664) | Multi-objective, high-dimensional |        AAAI 2017         |   
[Multi-LineBO](http://proceedings.mlr.press/v97/kirschner19a/kirschner19a.pdf) | Multi-objective, high-dimensional |        ICML 2019         |
[K-RVEA](https://ieeexplore.ieee.org/document/7723883) | Many-objective, low-dimensional |IEEE Transactions on Evolutionary Computation 2016 |  
[MOEA/D-ASS](https://ieeexplore.ieee.org/document/9626546) | Multi-objective, low-dimensional |IEEE Transactions on Cybernetics 2023 | 

## Benchmark Problems
Benchmark problems contain six three-objective benchmark problems taken from the DTLZ test suite [[9]](#dtlz), four three-objective benchmark problems from WFG test suite [[10]](#wfg), four three-objective benchmark problems from mDTLZ test suite [[11]](#mdtlz) and two optimization problems in transportation systems, including car side impact problem [[12]](#car1) and car cab design with preference information [[13]](#car2). 
|    Problem      |                   M| D                           | Descriptions
| :---------: | :-----------------------------------------------------: | :------------------------------------------------------------------------------------: | :---------------: |
[DTLZ](https://www.cs.bham.ac.uk/~jdk/parego/) | 3 |  10,20,30,40,50  |  DTLZ11, DTLZ2, DTLZ3,DTLZ5, DTLZ6, DTLZ7|
[WFG](https://ieeexplore.ieee.org/document/5353656) | 3 | 10,20,30,40,50  | WFG1-4|
[mDTLZ](https://ieeexplore.ieee.org/document/8372962) | 3 | 10,20  | mDTLZ1-4|
[Car Side Impact Problem](https://ieeexplore.ieee.org/document/6595567) | 4 |7  | -|
[car cab design with preference information](https://ieeexplore.ieee.org/document/5196713) | 2 |11  | -|
<!-- [UF](https://ojs.aaai.org/index.php/AAAI/article/view/10664) | 2 | 10| UF1-7       |    -->
<!-- [Hyper-parameter Tuning](http://www2.imm.dtu.dk/pubdb/edoc/imm6284.pdf) | 2 |  5 |Objectives include error and prediction time. Hyper-parameters include the number of hidden layers, number of neurons per hidden layer, learning rate, dropout rate and L2 regularization weight penalties

M and D are the number of objectives and decision variables, respectively. -->

<!-- ## Results
All the baseline results recorded in our paper are reported in [Google Cloud Drive](https://drive.google.com/drive/folders/1ANE701izoLUNoADnfkngrapyTqHCHyGS). -->


## Citation
Please cite our paper if you find our work useful for your research:
```
@article{WANG2023,
title = {High-Dimensional Multi-Objective Bayesian Optimization With Block Coordinate Updates: Case Studies in Intelligent Transportation System},
author = {Hongyan Wang, Hua Xu and Zeqiu Zhang},
journal = {IEEE Transactions on Intelligent Transportation Systems},
year = {2023},
doi = {10.1109/TITS.2023.3241069},
}
```
If there's any question, please feel free to contact why17@mails.tsinghua.edu.cn and zzhang77@gwmail.gwu.edu.

## References

<a name="1">
</a>

[1] K. Deb, A. Pratap, S. Agarwal and T. Meyarivan, [A fast and elitist multiobjective genetic algorithm: NSGA-II](https://ieeexplore.ieee.org/document/996017), IEEE Transactions on Evolutionary Computation, vol. 6, no. 2, pp. 182-197, April 2002.

<a name="2">
</a>

[2] N.Beume,B.Naujoks,andM.Emmerich, [SMS-EMOA: Multiobjective selection based on dominated hypervolume](https://www.sciencedirect.com/science/article/pii/S0377221706005443), European Journal of Operational Research, vol. 181, no. 3, pp. 1653–1669, 2007.

<a name="3">
</a>

[3] J. Knowles, [ParEGO: a hybrid algorithm with on-line landscape approximation for expensive multi-objective optimization problems](https://ieeexplore.ieee.org/document/1583627), IEEE Transactions on Evolutionary Computation 10 (1) (2006) 50–66.

<a name="4">
</a>

[4] Q. Zhang, W. Liu, E. Tsang, B. Virginas, [Expensive multi-objective optimization by MOEA/D with Gaussian process model](https://ieeexplore.ieee.org/document/5353656), IEEE Transactions on Evolutionary Computation 14 (3) (2010) 456–474.

<a name="5">
</a>

[5] H. Qian, Y. Yu, [Solving high-dimensional multi-objective optimization problems with low effective di- mensions](https://ojs.aaai.org/index.php/AAAI/article/view/10664), in: Proceedings of the 31st AAAI Conference on Artificial Intelligence, AAAI’17, AAAI Press, 2017, p. 875–881.

<a name="6">
</a>

[6] T. Chugh, Y. Jin, K. Miettinen, J. Hakanen, and K. Sindhya, [A surrogate-assisted reference vector guided evolutionary algorithm for computationally expensive many-objective optimization](https://ieeexplore.ieee.org/document/7723883), IEEE Transactions on Evolutionary Computation, vol. 22, no. 1, pp. 129–142, Feb. 2018.

<a name="7">
</a>

[7] Z. Wang, Q. Zhang, Y.-S. Ong, S. Yao, H. Liu, and J. Luo, [Choose appropriate subproblems for collaborative modeling in expensive multiobjective optimization](https://ieeexplore.ieee.org/document/9626546), IEEE Transactions on Cybernetics, vol. 53, no. 1, pp. 483–496, Jan. 2023.

<a name="8">
</a>

[8] J. Kirschner, M. Mutny, N. Hiller, R. Ischebeck, A. Krause, [Adaptive and safe bayesian optimization in high dimensions via one-dimensional subspaces](http://proceedings.mlr.press/v97/kirschner19a/kirschner19a.pdf), Proceedings of the 36th International Conference on Machine Learning, Vol. 97 of ICML’19, PMLR, Long Beach, California, USA, 2019, pp. 3429–3438.

<a name="9">
</a>

[9] K. Deb, L. Thiele, M. Laumanns, E. Zitzler, [Scalable Test Problems for Evolutionary Multiobjective Optimization](https://link.springer.com/chapter/10.1007/1-84628-137-7_6), Springer London, London, 2005, pp. 105–145.

<a name="10">
</a>

[10] Huband, S., Barone, L., While, L., Hingston, P. [A Scalable Multi-objective Test Problem Toolkit](https://link.springer.com/chapter/10.1007/978-3-540-31880-4_20). In: Coello Coello, C.A., Hernández Aguirre, A., Zitzler, E. (eds) Evolutionary Multi-Criterion Optimization. EMO 2005.

<a name="11">
</a>

[11] Z. Wang, Y.-S. Ong, and H. Ishibuchi, [On scalable multiobjective test problems with hardly dominated boundaries](https://ieeexplore.ieee.org/document/8372962), IEEE Transactions on Evolutionary Computation, vol. 23, no. 2, pp. 217–231, Apr. 2018.

<a name="12">
</a>

[12] H. Jain and K. Deb, [An evolutionary many-objective optimization algorithm using reference-point based nondominated sorting approach, Part II: Handling constraints and extending to an adaptive approach](https://ieeexplore.ieee.org/document/6595567), IEEE Transactions on Evolutionary Computation, vol. 18, no. 4, pp. 602–622, Aug. 2014.

[13] K. Deb, S. Gupta, D. Daum, J. Branke, A. K. Mall, and D. Padmanabhan, [Reliability-based optimization using evolutionary algorithms](https://ieeexplore.ieee.org/document/5196713), IEEE Transactions on Evolutionary Computation, vol. 13, no. 5, pp. 1054–1074, Oct. 2009.

