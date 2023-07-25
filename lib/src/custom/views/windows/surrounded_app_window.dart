
import 'package:flutter/material.dart';

class SurroundedAppWindow extends StatefulWidget {
  final Widget? child;

  const SurroundedAppWindow({super.key, this.child});


  @override
  State<SurroundedAppWindow> createState() => _SurroundedAppWindowState();
}

class _SurroundedAppWindowState extends State<SurroundedAppWindow> {
  Widget get child  => widget.child ?? Container();

  @override
  void initState() {
    super.initState();
  }
  static const TextDirection textDirection = TextDirection.ltr;

  bool isDragging = false;

  final double surroundingSpaceHorizontalInset = 15.0;
  final double surroundingSpaceVerticalInset = 15.0;


  @override
  Widget build(BuildContext context) {
    
    return Directionality(
    textDirection:  textDirection,
    child: Container(
      color: Theme.of(context).colorScheme.background,
      child: Stack(
        children: [
          Column(
            children: [
    
              _buildDraggableSpace(height: surroundingSpaceVerticalInset),

                    Expanded(
                        child: 
                      Row(children: 
                        [
                        _buildDraggableSpace(width: surroundingSpaceHorizontalInset), 
                        
                        Expanded(child: child), 
                        
                        _buildDraggableSpace(width: surroundingSpaceHorizontalInset),
                        ],)),
    
              
              _buildDraggableSpace(height: surroundingSpaceVerticalInset),
    
    
            ],
    
             
            ),

            Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 2, 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                        _buildWindowBarButton(iconData: Icons.minimize, onPressed: onMinimize),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: _buildWindowBarButton(iconData: Icons.maximize, onPressed: onMaximize),
                        ),

                        _buildWindowBarButton(iconData: Icons.close, onPressed: onClose),

                      ],),
                    ))
        ],
      )));
        
      
    
  }

  Widget _buildWindowBar() => GestureDetector(
    onTapDown: (details) => startDragging(),
    child: Row(
      children: [
      Expanded(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text("Flashcard App", style: TextStyle(color: Colors.black)),
      ))
    ],));


  Widget _buildWindowBarButton({required IconData iconData, required void Function() onPressed}) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black)),
      child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onPressed(),
                      child: Icon(iconData)
                      )),
                  );
    
  }

  

  void onMinimize() {
   // windowManager.minimize();
  }
  void onMaximize() {
   // windowManager.maximize();
  }
  void onClose() {
    //windowManager.close();
  }
  
  Future<void> startDragging() async {
    //await windowManager.drag();
  }

  Widget _buildDraggableSpace({double? height, double? width}) {
    
    return Container(
      child: GestureDetector(
        
        onTapDown: (details) => startDragging(),
        child: SizedBox(
        
          width: width,
          height: height,
          child: MouseRegion(
            onHover: (event) {
              
            },
            cursor: SystemMouseCursors.move,
          )),
      ),
    );
  }
  
}
