# QRI-ELM and ELM with Standard Momentum

Project for the Computational Mathematics for Data Analysis and Learning course @ [University of Pisa](https://www.unipi.it/index.php/english)

<img src="imgs/unipi_logo.png" align="right" alt="Unipi logo">

Authors: [Alberto Marinelli](https://github.com/AlbertoMarinelli), [Martina Melero Cavallo](https://github.com/mmc185)


## Abstract
In order to extract the relationships underlying large volumes of data, neural networks have become the predominant choice for machine learning applications. While reasonably good performance can be achieved with Single Layer Feed-forward Networks (SLFNs) trained using a classical Back-Propagation (BP) approach, these algorithms are still slow in learning and have other disadvantages. Recently, some alternative algorithms have been proposed to address these problems.
<br/> <br/>
In this project it is used a (M) Machine Learning model based on a method called **Extreme Learning** proposed by Huang et al., with the employment of L2-regularization. In particular, a comparison was carried out between: (A1) which is a variant of incremental extreme learning machine (I-ELM) that is QRIELM, which uses **QR factorization** to decompose the matrix of the hidden output layer, reducing the computational complexity involved in computing the Moore-Penrose inverse, and (A2) which is a **standard momentum descent** (heavy ball) approach, applied to the Extreme Learning Machine.
<br /><br />

## Main Results
The study compared two approaches, QRI-ELM and ELM with Standard Momentum, and evaluated their results. QRI-ELM outperformed ELM with Standard Momentum in terms of **solution quality**, almost reaching machine precision. ELM, even with optimal learning rate and momentum, achieved a lower solution quality of ≈1e-11.

The **computational complexity** of ELM with optimal values makes it impractical for real-world problems. Therefore, it is important to consider results obtained with other values, which are more likely to be used for complex problems. The study found that the regularization coefficient had a significant impact on the performance of ELM with Standard Momentum. Decreasing λ value resulted in considerably worse solutions, increased iterations, and longer convergence time. On the other hand, larger regularization coefficients reduced the time required to find the solution.

QRI-ELM, unlike ELM with Standard Momentum, was not affected by changes in the λ value. Its convergence time remained constant at around 15 seconds for 150 neurons. Although ELM was faster, it was less precise. In the experiments, the automatic determination of the number of neurons by QRI-ELM was not useful because the established upper bound was always met. In contrast, for ELM with Standard Momentum, determining the optimal number of neurons was necessary, which required additional time but struck a balance between model complexity and performance.

In terms of **scalability**, QRI-ELM suffered the most from an increase in columns, while its accuracy only slightly decreased. ELM's scalability was greatly influenced by the regularization coefficient. Larger values resulted in fewer iterations and faster convergence, while smaller λ values required more iterations and could even reach the maximum number of iterations. When a small regularization coefficient was combined with a large number of neurons, ELM produced unacceptable solutions, favoring the QRI-ELM approach. Generally, ELM with Standard Momentum was faster but slightly less accurate (≈e-11) compared to QRI-ELM (≈e-15). ELM with Standard Momentum provided a better trade-off between accuracy and execution time in most cases. The gap pred showed little difference between the two algorithms, except for specific cases.

Overall, the study aimed to explore the two approaches in convex optimization cases. The results indicated that ELM with Standard Momentum, due to its multiple parameters, requires a search for optimal values or approximations when optimal values cannot be derived. In contrast, QRI-ELM overcomes this issue and demonstrates that incremental computations do not affect the quality of the factorization obtained.


## Languages and Tools
<p align="left"> <a href="https://www.mathworks.com/" target="_blank" rel="noreferrer"> <img src="https://upload.wikimedia.org/wikipedia/commons/2/21/Matlab_Logo.png" alt="matlab" width="40" height="40"/> </a></p>
