import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraficosScreen extends StatelessWidget {
  const GraficosScreen({super.key});

  // BPM por hora
  static final List<_HrPoint> _hrData = [
    _HrPoint('08h', 72),
    _HrPoint('09h', 75),
    _HrPoint('10h', 90),
    _HrPoint('11h', 88),
    _HrPoint('12h', 70),
    _HrPoint('13h', 68),
    _HrPoint('14h', 95),
    _HrPoint('15h', 100),
    _HrPoint('16h', 78),
    _HrPoint('17h', 74),
    _HrPoint('18h', 85),
    _HrPoint('19h', 82),
    _HrPoint('20h', 69),
  ];

  // Nível de estresse por dia
  static final List<_StressPoint> _stressData = [
    _StressPoint('Seg', 6, const Color(0xFFE53935)),
    _StressPoint('Ter', 9, const Color(0xFFE53935)),
    _StressPoint('Qua', 4, const Color(0xFFFFB300)),
    _StressPoint('Qui', 7, const Color(0xFFE53935)),
    _StressPoint('Sex', 5, const Color(0xFF43A047)),
    _StressPoint('Sab', 3, const Color(0xFF43A047)),
    _StressPoint('Dom', 8, const Color(0xFFE53935)),
  ];

  // Corpo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'GRÁFICOS',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildStatsRow(),
                    const SizedBox(height: 20),
                    _buildStressBarChart(),
                    const SizedBox(height: 24),
                    _buildHeartRateChart(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE8F5E9),
              border: Border.all(color: const Color(0xFF4CAF50), width: 1.5),
            ),
            child: const Icon(Icons.person, size: 20, color: Color(0xFF4CAF50)),
          ),
          const SizedBox(width: 12),
          const Text(
            'PUZZLE BAND',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Color(0xFF222222),
            ),
          ),
        ],
      ),
    );
  }

  // Caixas de status
  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatBox(label: 'MÉDIA BPM', value: '85', unit: 'bpm'),
        const SizedBox(width: 16),
        _buildStatBox(label: 'PICOS DE ESTRESSE\nMÊS', value: '15', unit: ''),
      ],
    );
  }

  Widget _buildStatBox({
    required String label,
    required String value,
    required String unit,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF888888),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111111),
                    height: 1.1,
                  ),
                ),
                if (unit.isNotEmpty) ...[
                  const SizedBox(width: 2),
                  Text(
                    unit,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF888888),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Frequência Cardíaca
  Widget _buildHeartRateChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Frequência Cardíaca — Últimas Horas',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF888888),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 200,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              margin: const EdgeInsets.only(top: 8),
              primaryXAxis: const CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                labelStyle: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
                axisLine: AxisLine(width: 0),
                majorTickLines: MajorTickLines(size: 0),
              ),
              primaryYAxis: const NumericAxis(
                minimum: 50,
                maximum: 120,
                interval: 20,
                labelStyle: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
                majorGridLines: MajorGridLines(
                  width: 1,
                  color: Color(0xFFEEEEEE),
                  dashArray: [4, 4],
                ),
                axisLine: AxisLine(width: 0),
                majorTickLines: MajorTickLines(size: 0),
              ),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                header: '',
                format: 'point.x  •  point.y bpm',
                color: Color(0xFF222222),
                textStyle: TextStyle(fontSize: 11, color: Colors.white),
              ),
              series: [
                SplineAreaSeries<_HrPoint, String>(
                  dataSource: _hrData,
                  xValueMapper: (p, _) => p.hour,
                  yValueMapper: (p, _) => p.bpm,
                  color: const Color(0xFFE53935).withOpacity(0.15),
                  borderColor: const Color(0xFFE53935),
                  borderWidth: 2.5,
                  splineType: SplineType.monotonic,
                  animationDuration: 1200,
                  markerSettings: const MarkerSettings(
                    isVisible: true,
                    height: 6,
                    width: 6,
                    color: Color(0xFFE53935),
                    borderColor: Colors.white,
                    borderWidth: 1.5,
                    shape: DataMarkerType.circle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Nível de estresse por dia
  Widget _buildStressBarChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nível de Estresse por Dia',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF888888),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 200,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              margin: const EdgeInsets.only(top: 8),
              primaryXAxis: const CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                labelStyle: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
                axisLine: AxisLine(width: 0),
                majorTickLines: MajorTickLines(size: 0),
              ),
              primaryYAxis: const NumericAxis(
                minimum: 0,
                maximum: 10,
                interval: 2,
                labelStyle: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
                majorGridLines: MajorGridLines(
                  width: 1,
                  color: Color(0xFFEEEEEE),
                  dashArray: [4, 4],
                ),
                axisLine: AxisLine(width: 0),
                majorTickLines: MajorTickLines(size: 0),
              ),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                header: '',
                format: 'point.x  •  point.y / 10',
                color: Color(0xFF222222),
                textStyle: TextStyle(fontSize: 11, color: Colors.white),
              ),
              series: [
                ColumnSeries<_StressPoint, String>(
                  dataSource: _stressData,
                  xValueMapper: (p, _) => p.day,
                  yValueMapper: (p, _) => p.level,
                  pointColorMapper: (p, _) => p.color,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(5),
                  ),
                  width: 0.55,
                  animationDuration: 1200,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: false,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendItem(const Color(0xFFE53935), 'Alto'),
              const SizedBox(width: 16),
              _legendItem(const Color(0xFFFFB300), 'Moderado'),
              const SizedBox(width: 16),
              _legendItem(const Color(0xFF43A047), 'Calmo'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF888888)),
        ),
      ],
    );
  }
}

class _HrPoint {
  final String hour;
  final int bpm;
  const _HrPoint(this.hour, this.bpm);
}

class _StressPoint {
  final String day;
  final int level;
  final Color color;
  const _StressPoint(this.day, this.level, this.color);
}
