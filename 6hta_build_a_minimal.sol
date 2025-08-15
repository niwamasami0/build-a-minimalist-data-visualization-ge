pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract MinimalDataVisualizationGenerator {
    using SafeMath for uint256;

    // Mapping to store datasets
    mapping(address => uint256[]) public datasets;

    // Struct to represent a data visualization
    struct Visualization {
        uint256[] dataPoints;
        uint256 xAxisMin;
        uint256 xAxisMax;
        uint256 yAxisMin;
        uint256 yAxisMax;
    }

    // Mapping to store visualizations
    mapping(address => Visualization) public visualizations;

    // Event emitted when a new dataset is added
    event NewDataset(address indexed owner, uint256[] dataPoints);

    // Event emitted when a new visualization is generated
    event NewVisualization(address indexed owner, Visualization visualization);

    // Function to add a new dataset
    function addDataset(uint256[] memory _dataPoints) public {
        datasets[msg.sender].push(_dataPoints);
        emit NewDataset(msg.sender, _dataPoints);
    }

    // Function to generate a new visualization
    function generateVisualization(uint256 _xAxisMin, uint256 _xAxisMax, uint256 _yAxisMin, uint256 _yAxisMax) public {
        Visualization memory visualization;
        visualization.dataPoints = datasets[msg.sender][datasets[msg.sender].length - 1];
        visualization.xAxisMin = _xAxisMin;
        visualization.xAxisMax = _xAxisMax;
        visualization.yAxisMin = _yAxisMin;
        visualization.yAxisMax = _yAxisMax;
        visualizations[msg.sender] = visualization;
        emit NewVisualization(msg.sender, visualization);
    }

    // Function to get a visualization
    function getVisualization() public view returns (Visualization memory) {
        return visualizations[msg.sender];
    }
}